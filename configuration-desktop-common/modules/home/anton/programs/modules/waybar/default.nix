{ pkgs, config, lib, ... }@input:
let scripts = import ./scripts input;
in {
  imports = [ ./style.nix ];

  programs.waybar = with config.lib.base16.theme; {
    package = pkgs.waybar;
    enable = config.wayland.windowManager.sway.enable;
    # enable = true;
    systemd.enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 42;
      modules-left = [ "sway/workspaces" "sway/mode" ];
      modules-center = [ "sway/window" ];
      modules-right = [
        "custom/spotify"
        "tray"
        "pulseaudio"
        # "network#ethernet"
        # "network#wifi"
        "battery"
        "clock"
        "idle_inhibitor"
        "custom/layout"
      ];
      modules = {
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
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
        tray = {
          icon-size = 23;
          spacing = 10;
        };
        clock = {
          tooltip-format = "{:%Y-%m-%d | %H:%M}";
          format-alt = "{:%Y-%m-%d}";
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
        # "network#wifi" = {
        #   interface = "wlp0s20f3";
        #   format = "{essid} ({signalStrength}%) ";
        #   format-disconnected = "";
        #   tooltip-format-wifi = "{essid} ({signalStrength}%) ";
        #   tooltip-format-disconnected = "Disconnected";
        #   max-length = 50;
        # };
        # "network#ethernet" = {
        #   interface = "enp0s31f6";
        #   format = "";
        #   format-disconnected = "";
        #   tooltip-format-ethernet = "{ifname} ";
        #   tooltip-format-disconnected = "Disconnected";
        #   max-length = 50;
        # };
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
          exec-if = "pgrep spotify";
        };
        "custom/layout" = {
          "tooltip" = false;
          "exec" = ''
            swaymsg -t get_inputs | jq -r '.[] | select(.identifier == "1:1:AT_Translated_Set_2_keyboard") | .xkb_active_layout_name | .[0:2] | ascii_upcase'; \
            swaymsg -mrt subscribe '["input"]' | jq -r --unbuffered "select(.change == \"xkb_layout\") | .input | select(.type == \"keyboard\") | .xkb_active_layout_name | .[0:2] | ascii_upcase"
          '';
        };
        # "sway/language" = {};
      };
    }];
  };
}
