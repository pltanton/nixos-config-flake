{
  config,
  lib,
  ...
}: let
  hyprlandPkg = config.wayland.windowManager.hyprland.package;
  hyprlockPkg = config.programs.hyprlock.package;
in {
  systemd.user.services.swayidle.Service.Environment = lib.mkForce [];

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || ${hyprlockPkg}/bin/hyprlock --immediate";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "${hyprlandPkg}/bin/hyprctl dispatch dpms on";
      };
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
