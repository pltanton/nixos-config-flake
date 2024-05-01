{ config, lib, pkgs, inputs, ... }:
let hyprlandPkg = config.wayland.windowManager.hyprland.package;
in {
  systemd.user.services.swayidle.Service.Environment = lib.mkForce [ ];

  services.hypridle = {
    enable = true;
    lockCmd = "hyprlock";
    beforeSleepCmd = "hyprlock --immediate";
    afterSleepCmd = "${hyprlandPkg}/bin/hyprctl dispatch dpms on";
    listeners = [
      {
        timeout = 200;
        onTimeout = "hyprlock";
      }
      {
        timeout = 300;
        onTimeout = "${hyprlandPkg}/bin/hyprctl dispatch dpms off";
        onResume = "${hyprlandPkg}/bin/hyprctl dispatch dpms on";
      }
      {
        timeout = 900; # 15 min
        onTimeout = "systemctl suspend";
        onResume = "${hyprlandPkg}/bin/hyprctl dispatch dpms on";
      }
    ];
  };
}
