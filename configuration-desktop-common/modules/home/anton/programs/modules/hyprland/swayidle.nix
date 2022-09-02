{ config, lib, pkgs, inputs, ... }: {
  services.swayidle = lib.mkIf config.wayland.windowManager.hyprland.enable {
    enable = true;
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
        command = "hyprctl dispatch dpms on";
      }
    ];
    timeouts = [
      {
        timeout = 200;
        command = "lock";
      }
      {
        timeout = 300;
        command = "hyprctl dispatch dpms off";
        resumeCommand = "hyprctl dispatch dpms on";
      }
    ];
  };
}
