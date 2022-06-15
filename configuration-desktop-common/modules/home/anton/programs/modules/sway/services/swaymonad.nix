{ config, lib, pkgs, inputs, ... }:
with lib;
let cfg = config.services.swaymonad;
in {
  options = {
    services.swaymonad = {
      enable = mkOption {
        default = false;
        description = ''
          Whether to enable swaymonad autotiling script.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    systemd.user.services.swaymonad = {
      Unit = {
        Description = "Service to wrap swaymonad script";
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart =
          "${inputs.swaymonad.defaultPackage.x86_64-linux}/bin/swaymonad";
        Restart = "always";
      };

      Install = { WantedBy = [ "graphical-session.target" ]; };
    };
  };
}
