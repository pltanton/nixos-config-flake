{ pkgs, config, lib, ... }: {
  imports = [ ./style.nix ];

  programs.waybar = {
    enable = true;
    systemd.enable = false;
    settings = [{
      layer = "top";
      position = "top";
      height = 32;
      modules-left = [ "sway/workspaces" "sway/mode" ];
      modules-center = [ "sway/window" ];
      modules-right =
        [ "tray" "pulseaudio" "battery" "clock" "idle_inhibitor" ];
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

            "im" = "";

            "focused" = "";
            "default" = "";
          };
        };
        tray = {
          icon-size = 21;
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
      };
    }];
  };
}
