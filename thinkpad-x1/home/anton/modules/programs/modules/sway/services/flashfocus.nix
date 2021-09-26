{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.flashfocus;
  script = pkgs.stdenv.mkDerivation {
    name = "keyboard-layout-per-window";
    buildInputs = [
      (pkgs.python38.withPackages
        (pythonPackages: with pythonPackages; [ i3ipc ]))
    ];
    unpackPhase = "true";
    installPhase = ''
      mkdir -p $out/bin
      cp ${./keyboard-layout-per-window.py} $out/bin/keyboard-layout-per-window
      chmod +x $out/bin/keyboard-layout-per-window
    '';
  };
in {
  options = {
    services.flashfocus = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable per window keyboard layout watcher script.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.flashfocus = {
      Unit = {
        Description = "Service to wrap flashfocus utility";
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${pkgs.flashfocus}/bin/flashfocus -t 200";
        Restart = "always";
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
    };
  };
}
