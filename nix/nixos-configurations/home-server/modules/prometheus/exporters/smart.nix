{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.services.prometheus.custom-exporters.smart;
  smartmon = pkgs.stdenv.mkDerivation {
    name = "smartmon";
    src = pkgs.fetchFromGitHub {
      owner = "prometheus-community";
      repo = "node-exporter-textfile-collector-scripts";
      rev = "414fb44693444cb96a55c7152cdd84d531888e1f";
      sha256 = "13ja3l78bb47xhdfsmsim5sqggb9avg3x872jqah1m7jm9my7m98";
    };
    buildInputs = with pkgs; [ light ddcutil ];
    installPhase = ''
      mkdir -p $out/bin;
      cp -v smartmon.sh $out/bin/smartmon
      substituteInPlace $out/bin/smartmon \
        --replace /bin/bash ${pkgs.bash}/bin/bash \
        --replace /usr/sbin ${pkgs.smartmontools}/bin;
      substituteAllInPlace $out/bin/smartmon;

      chmod +x $out/bin/smartmon
    '';
  };

  smart-textfile-exporter = pkgs.writeShellScript "smart-textfile-exporter" ''
    mkdir -p /var/lib/node_exporter/textfile_collector
    ${smartmon}/bin/smartmon > /var/lib/node_exporter/textfile_collector/smartmon.prom
    # chown -R node-exporter:node-exporter /var/lib/node_exporter
  '';

in {
  config = mkIf cfg.enable {
    systemd = {
      services = {
        smart-exporter = {
          enable = true;
          description = "Smart prometheus exporter";
          wantedBy = [ "default.target" ];
          path = with pkgs; [
            rsync
            kmod
            gawk
            nettools
            util-linux
            profile-sync-daemon
          ];
          unitConfig = { RequiresMountsFor = [ "/home/" ]; };
          serviceConfig = {
            Type = "oneshot";
            ExecStart = "${smart-textfile-exporter}";
          };
        };
      };

      timers.smart-exporter-timer = {
        description = "Timer for smart prometheus exporter - ${cfg.timer}";
        partOf = [ "smart-exporter.service" ];

        timerConfig = { OnUnitActiveSec = "${cfg.timer}"; };
      };
    };
  };
}
