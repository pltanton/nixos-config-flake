{
  config,
  lib,
  ...
}: let
  hyprlandPkg = config.wayland.windowManager.hyprland.package;
in {
  systemd.user.services.swayidle.Service.Environment = lib.mkForce [];

  services.hypridle = {
    enable = true;
    settings = {
      lockCmd = "hyprlock";
      beforeSleepCmd = "hyprlock --immediate";
      afterSleepCmd = "${hyprlandPkg}/bin/hyprctl dispatch dpms on";
      listener = [
        {
          timeout = 200;
          on-timeout = "hyprlock";
        }
        {
          timeout = 300;
          on-timeout = "${hyprlandPkg}/bin/hyprctl dispatch dpms off";
          on-resume = "${hyprlandPkg}/bin/hyprctl dispatch dpms on";
        }
        {
          timeout = 900; # 15 min
          on-timeout = "systemctl suspend";
          on-resume = "${hyprlandPkg}/bin/hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
