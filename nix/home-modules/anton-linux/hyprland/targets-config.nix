{
  config,
  lib,
  ...
}: let
  target = "graphical-session.target";
in
  lib.mkIf config.wayland.windowManager.hyprland.enable {
    systemd.user.services = {
      waybar = {
        Unit.After = lib.mkForce [target];
        Unit.PartOf = [target];
        Install.WantedBy = lib.mkForce [target];
      };
      hyprpaper = {
        Unit.After = lib.mkForce [target];
        Unit.PartOf = [target];
        Install.WantedBy = lib.mkForce [target];
      };
      hypridle = {
        Unit.After = lib.mkForce [target];
        Unit.PartOf = [target];
        Install.WantedBy = lib.mkForce [target];
      };
    };
  }
