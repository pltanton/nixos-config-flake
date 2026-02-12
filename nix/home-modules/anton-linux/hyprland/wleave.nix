{
  config,
  lib,
  ...
}: lib.mkIf config.wayland.windowManager.hyprland.enable {
  programs.wleave = {
    enable = true;

    style = ''
      window {
        background-color: rgba(12, 12, 12, 0.45);
      }
    '';

    settings = {
      margin = 200;
      buttons-per-row = "1/2";
      delay-command-ms = 100;
      close-on-lost-focus = true;
      show-keybinds = true;
      no-version-info = true;

      buttons = [
        {
          label = "lock";
          action = "loginctl lock-session";
          text = "Lock";
          keybind = "l";
        }
        {
          label = "logout";
          action = "hyprshutdown --post-cmd 'uwsm stop'";
          text = "Logout";
          keybind = "e";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Suspend";
          keybind = "s";
        }
        {
          label = "hibernate";
          action = "systemctl hibernate";
          text = "Hibernate";
          keybind = "h";
        }
        {
          label = "reboot";
          action = "hyprshutdown --post-cmd 'reboot'";
          text = "Reboot";
          keybind = "r";
        }
        {
          label = "shutdown";
          action = "hyprshutdown --post-cmd 'shutdown -P 0'";
          text = "Shutdown";
          keybind = "p";
        }
      ];
    };
  };
}
