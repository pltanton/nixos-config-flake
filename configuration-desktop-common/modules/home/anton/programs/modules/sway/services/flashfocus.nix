{ config, lib, pkgs, ... }:
with lib;
let cfg = config.services.flashfocus;
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
        ExecStart = "${pkgs.flashfocus}/bin/flashfocus -t 250";
        Restart = "always";
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
    };
  };
}
