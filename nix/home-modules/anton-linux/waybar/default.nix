{
  pkgs,
  config,
  ...
} @ input: let
  scripts = import ./scripts input;
  hyprlandPkg = config.wayland.windowManager.hyprland.package;
  swayncClient = "${config.services.swaync.package}/bin/swaync-client";
  catppuccinRed = "f38ba8";
in {
  programs.waybar = {
    style = builtins.readFile ./waybar.css;
    package = pkgs.unstable.waybar;
    enable = true;
    # enable = true;https://my.telegram.org/auth?to=delete
    systemd.enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        # height = 24;
        height = 18;
        margin = "7 16 0 16";
        # margin = "0 0 0 0";
        modules-left = ["hyprland/workspaces" "custom/spotify" "hyprland/submap"];
        modules-center = ["hyprland/window"];
        modules-right = [
          "tray"

          "bluetooth"
          "network"
          "wireplumber"

          "idle_inhibitor"
          "custom/notification"
          "temperature"
          "hyprland/language"
          "clock"
          "battery"
        ];
        "temperature" = {
          "format" = " {temperatureC}°C";
          "thermal-zone" = 3;
          "critical-threshold" = 90;
          "format-critical" = " {temperatureC}°C";
        };
        "bluetooth" = {
          "format" = "";
          "format-connected" = " {num_connections}";
          "tooltip-format" = "{controller_alias}\n{num_connections} connected";
          "tooltip-format-connected" = "{controller_alias}\n{num_connections} connected";
          "tooltip-format-disabled" = "Bluetooth disabled";
          "on-click" = "${pkgs.ghostty}/bin/ghostty --class=ghostty.bluetui -e ${pkgs.bluetui}/bin/bluetui";
        };
        "network" = {
          "format-wifi" = " {signalStrength}%";
          "format-ethernet" = "󰈀 {ipaddr}";
          "format-disconnected" = "󰖪";
          "tooltip-format-wifi" = "{essid} ({signalStrength}%) {ipaddr}";
          "tooltip-format-ethernet" = "{ifname} {ipaddr}";
          "tooltip-format-disconnected" = "Disconnected";
          "on-click" = "${pkgs.ghostty}/bin/ghostty --class=ghostty.impala -e ${pkgs.impala}/bin/impala";
        };
        "wireplumber" = {
          "format" = "{icon} {volume}%";
          "format-muted" = "";
          "on-click" = "pavucontrol";
          "format-icons" = ["" "" ""];
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
          "format-icons" = ["" "" ""];
        };
        "sway/mode" = {format = ''<span style="italic">{}</span>'';};
        "hyprland/workspaces" = {
          # format = "{name}: {icon}";
          format = "{name}";
          # format = "{name}: {windows}";
          sort-by = "number";
          on-click = "activate";
          on-scroll-down = "${hyprlandPkg}/bin/hyprctl dispatch workspace e+1";
          on-scroll-up = "${hyprlandPkg}/bin/hyprctl dispatch workspace e-1";

          window-rewrite-default = "";
          window-rewrite = {
            "title<.*youtube.*>" = ""; #
            "class<firefox>" = "";
            "class<.*jetbrains.*>" = "";
            "foot" = "";
            "VSCodium" = "";
            "class<com.mitchellh.ghostty>" = "";
            "class<org.telegram.desktop>" = "";
            "class<Slack>" = "";
            "spotify" = "";
          };

          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "8" = "";
            "9" = "";
            "tab" = "";
            "focused" = "";
            "default" = "";
          };
        };
        tray = {
          icon-size = 14;
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
          format-icons = ["" "" "" "" ""];
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
            default = ["" ""];
          };
          on-click = "pavucontrol";
          ignored-sinks = ["EasyEffects Sink"];
        };
        "custom/spotify" = {
          format = " {}";
          max-length = 40;
          on-click = "playerctl play-pause";
          interval = 1;
          exec = "${scripts.mediaplayer}/bin/mediaplayer 2> /dev/null";
          exec-if = "${pkgs.busybox}/bin/pgrep spotify";
        };
        "hyprland/sumbap" = {};
        "hyprland/window" = {
          "separate-outputs" = true;
          "max-length" = 50;
        };
        "hyprland/language" = {
          format = "{}";
          "format-ru" = "ру";
          "format-en" = "en";
          "format-gr-dvorak" = "ελ";
        };
        "custom/notification" = {
          "tooltip" = true;
          "format" = "{icon}";
          "format-icons" = {
            "notification" = "<span foreground='#${catppuccinRed}'>*</span>";
            "none" = "";
            "dnd-notification" = "";
            "dnd-none" = "";
            "inhibited-notification" = "";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = "";
            "dnd-inhibited-none" = "";
          };
          "return-type" = "json";
          "exec" = "${swayncClient} -swb";
          "on-click" = "${swayncClient} -t -sw";
          "on-click-right" = "${swayncClient} -d -sw";
          "escape" = true;
        };
      }
    ];
  };

  systemd.user.services.waybar.Service.Environment = ["PATH=$PATH:${hyprlandPkg}/bin"];
}
