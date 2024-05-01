{ pkgs, config, lib, ... }@input:
let
  scripts = import ./scripts input;
  hyprlandPkg = config.wayland.windowManager.hyprland.package;
in {
  programs.waybar = with config.lib.base16.theme; {
    style = builtins.readFile (config.lib.stylix.colors {
      template = builtins.readFile ./waybar.css.mustache;
      extension = "css";
    });
    package = pkgs.unstable.waybar;
    enable = config.wayland.windowManager.sway.enable
      || config.wayland.windowManager.hyprland.enable;
    # enable = true;https://my.telegram.org/auth?to=delete
    systemd.enable = true;
    settings = [{
      layer = "top";
      position = "top";
      # height = 24;
      height = 36;
      # margin = "10 18 0 18";
      margin = "0 0 0 0";
      modules-left =
        [ "hyprland/workspaces" "custom/spotify" "hyprland/submap" ];
      modules-center = [ "hyprland/window" ];
      modules-right = [
        "tray"
        "idle_inhibitor"
        "clock"
        "wireplumber"
        "temperature"
        "battery"
        "custom/kbd"
      ];
      "temperature" = {
        "format" = " {temperatureC}°C";
        "thermal-zone" = 3;
        "critical-threshold" = 90;
        "format-critical" = " {temperatureC}°C";
      };
      "wireplumber" = {
        "format" = "{icon} {volume}%";
        "format-muted" = "";
        "on-click" = "pavucontrol";
        "format-icons" = [ "" "" "" ];
      };
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
      "backlight" = {
        "device" = "intel_backlight";
        "format" = "{icon} {percent}%";
        "format-icons" = [ "" "" "" ];
      };
      "sway/mode" = { format = ''<span style="italic">{}</span>''; };
      "hyprland/workspaces" = {
        # format = "{name}: {icon}";
        format = "{name}";
        # sort-by-coordinates = false;
        sort-by-number = true;
        on-click = "activate";
        on-scroll-down = "${hyprlandPkg}/bin/hyprctl dispatch workspace e+1";
        on-scroll-up = "${hyprlandPkg}/bin/hyprctl dispatch workspace e-1";
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
        ignored-sinks = [ "EasyEffects Sink" ];
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
      "hyprland/sumbap" = { };
      "hyprland/window" = {
        "format" = "{}";
        "separate-outputs" = true;
      };
      "hyprland/language" = {
        "format" = "{}";
        "format-en" = "en";
        "format-ru" = "ru";
        # "keyboard-name" = "AT Translated Set 2 keyboard";
      };
    }];
  };

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };

  systemd.user.services.waybar.Service.Environment =
    [ "PATH=$PATH:${hyprlandPkg}/bin" ];
}
