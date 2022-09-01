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
        timeout = 300;
        command = "lock";
      }
      {
        timeout = 600;
        command = "hyprctl dispatch dpms off";
      }
    ];
  };
}
