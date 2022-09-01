{ config, lib, pkgs, inputs, ... }:
with lib;
let cfg = config.services.autotiling;
in {
  options = {
    services.autotiling = {
      workspaces = mkOption {
        description = ''
          Space-separated list of workspaces script runs on
        '';
        default = "1 2 3 4 5 6 7 9 0";
      };
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable autotiling app daemon.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.autotiling = {
      Unit = {
        Description = "Service to wrap autotiling script";
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart =
          "${pkgs.master.autotiling}/bin/autotiling -w ${cfg.workspaces}";
        Restart = "always";
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
    };
  };
}
