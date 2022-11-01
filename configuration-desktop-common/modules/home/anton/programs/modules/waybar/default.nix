{ pkgs, config, lib, ... }@input:
let scripts = import ./scripts input;
in {
  imports = [ ./style.nix ];

  programs.waybar = with config.lib.base16.theme; {
    # package = pkgs.waybar.overrideAttrs (oldAttrs: {
    #   mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    # });
    # package = if config.wayland.windowManager.sway.enable then
    #   pkgs.waybar
    # else
    #   pkgs.waybar-hyprland;
    package = pkgs.waybar-hyprland;
    enable = config.wayland.windowManager.sway.enable
      || config.wayland.windowManager.hyprland.enable;
    # enable = true;
    systemd.enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 29;
      margin = "12 18 0 18";
      modules-left = [
        # "sway/worspaces"
        "wlr/workspaces"
        "custom/spotify"
        "custom/submap"
        # "sway/mode"
      ];
      modules-center = [
        "hyprland/window"

      ];
      modules-right = [
        "tray"
        "idle_inhibitor"
        "clock"
        "pulseaudio"
        "battery"
        "custom/kbd"
        # "hyprland/language"
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
        "format" = " {}%";
        "max-length" = 10;
      };
      "cpu" = {
        "interval" = 10;
        "format" = " {}%";
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
        # sort-by-coordinates = false;
        sort-by-number = true;
        on-click = "activate";
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
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
        format = "{icon} {capacity}%";
        format-icons = [ "" "" "" "" "" ];
      };
      pulseaudio = {
        format = "{icon} {volume}%";
        format-bluetooth = "{icon} {volume}%";
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
        on-click = "playerctl play-pause";
        interval = 1;
        exec = "${scripts.mediaplayer}/bin/mediaplayer 2> /dev/null";
        exec-if = "${pkgs.busybox}/bin/pgrep spotify";
      };
      "custom/submap" = {
        format = "{}";
        return-type = "json";
        exec = "${scripts.hyprland-submap}/bin/hyprland-submap";
      };
      "custom/kbd" = {
        format = "{}";
        return-type = "json";
        exec = "${scripts.hyprland-kbd}/bin/hyprland-kbd";
      };
      "sway/language" = { "format" = "{short}"; };
      "hyprland/window" = { "format" = "{}"; };
      "hyprland/language" = {
        "format" = "{}";
        "format-en" = "en";
        "format-ru" = "ru";
        # "keyboard-name" = "AT Translated Set 2 keyboard";
      };
    }];
  };
}
