{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.services.keyboardLayoutPerWindow;
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
    services.keyboardLayoutPerWindow = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable per window keyboard layout watcher script.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.keyboard-layout-per-window = {
      Unit = {
        Description = "Keyboard layout per window script";
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${script}/bin/keyboard-layout-per-window";
        Restart = "always";
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
    };
  };
}
