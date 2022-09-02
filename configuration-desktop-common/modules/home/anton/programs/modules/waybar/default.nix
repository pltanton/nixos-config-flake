{ pkgs, config, lib, ... }@input:
let scripts = import ./scripts input;
in {
  imports = [ ./style.nix ];

  programs.waybar = with config.lib.base16.theme; {
    package = if config.wayland.windowManager.sway.enable then
      pkgs.waybar
    else
      pkgs.waybar-hyprland;
    enable = config.wayland.windowManager.sway.enable
      || config.wayland.windowManager.hyprland.enable;
    # enable = true;
    systemd.enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 49;
      modules-left = [ "cpu" "memory" ];
      modules-center = [ "wlr/workspaces" ];
      modules-right = [
        "custom/spotify"
        "tray"
        "clock"
        "keyboard-state"
        "pulseaudio"
        "battery"
        "idle_inhibitor"
      ];
      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };
      "memory" = {
        "interval" = 30;
        "format" = "{}% ";
        "max-length" = 10;
      };
      "cpu" = {
        "interval" = 10;
        "format" = "{}% ";
        "max-length" = 10;
      };
      "keyboard-state" = {
        "numlock" = false;
        "capslock" = true;
        "format" = "{name} {icon}";
        "format-icons" = {
          "locked" = "";
          "unlocked" = "";
        };
      };
      "sway/mode" = { format = ''<span style="italic">{}</span>''; };
      "sway/workspaces" = {
        numeric-first = true;
        disable-scroll = true;
        disable-markup = false;
        all-outputs = false;
        format = "  {value}: {icon}  ";
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "8" = "";
          "9" = "";
          "im" = "";
          "focused" = "";
          "default" = "";
        };
      };
      "wlr/workspaces" = {
        format = "{name}: {icon}";
        sort-by-coordinates = true;
        on-click = "activate";
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "8" = "";
          "9" = "";
          "10" = "";
          "focused" = "";
          "default" = "";
        };
      };
      tray = {
        icon-size = 15;
        spacing = 10;
      };
      clock = {
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
        format-alt = "{:%H:%M %Y-%m-%d}";
      };
      battery = {
        states = {
          good = 95;
          warning = 30;
          critical = 15;
        };
        format = "{capacity}% {icon}";
        format-icons = [ "" "" "" "" "" ];
      };
      pulseaudio = {
        format = "{volume}% {icon}";
        format-bluetooth = "{volume}% {icon}";
        format-muted = "";
        format-icons = {
          headphones = "";
          handsfree = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = [ "" "" ];
        };
        on-click = "pavucontrol";
      };
      "custom/spotify" = {
        format = " {}";
        max-length = 40;
        interval = 1;
        exec = "${scripts.mediaplayer} 2> /dev/null";
        exec-if = "${pkgs.busybox}/bin/pgrep spotify";
      };
      "sway/language" = { "format" = "{short}"; };
    }];
  };
}
