{ config, lib, pkgs, inputs, ... }:
let hyprlandPkg = config.wayland.windowManager.hyprland.package;
in {
  systemd.user.services.swayidle.Service.Environment = lib.mkForce [ ];
  services.swayidle = lib.mkIf config.wayland.windowManager.hyprland.enable {
    enable = false;
    events = [
      {
        event = "lock";
        command = "lock";
      }
      {
        event = "before-sleep";
        command = "lock";
      }
      {
        event = "after-resume";
        command = "${hyprlandPkg}/bin/hyprctl dispatch dpms on";
      }
    ];
    timeouts = [
      {
        timeout = 200;
        command = "lock --grace 5";
      }
      {
        timeout = 300;
        command = "${hyprlandPkg}/bin/hyprctl dispatch dpms off";
        resumeCommand = "${hyprlandPkg}/bin/hyprctl dispatch dpms on";
      }
    ];
  };

  services.hypridle = {
    enable = true;
    lockCmd = "lock";
    beforeSleepCmd = "lock";
  };
}
