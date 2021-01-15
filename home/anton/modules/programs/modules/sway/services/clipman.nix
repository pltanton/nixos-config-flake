{ config, lib, pkgs, ... }:
with lib;
let cfg = config.services.clipman;
in {
  options = {
    services.clipman = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable per window keyboard layout watcher script.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.clipman = {
      Unit = {
        Description = "Clipman service";
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart =
          "${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.clipman}/bin/clipman store";
        Restart = "always";
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
    };
  };
}
