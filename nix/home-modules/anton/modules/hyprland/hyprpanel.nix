{inputs, ...}: {
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];

  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    hyprland.enable = true;
    overwrite.enable = true;

    theme = "catppuccin_mocha";

    layout = {
      "bar.layouts" = {
        "*" = {
          left = ["dashboard" "workspaces" "submap" "media"];
          middle = ["windowtitle"];
          right = ["volume" "network" "bluetooth" "systray" "hypridle" "notifications" "kbinput" "battery"];
        };
      };
    };

    settings = {
      scalingPriority = "hyprland";

      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      menus = {
        clock = {
          time = {
            military = true;
            hideSeconds = true;
          };
          weather = {
            unit = "metric";
            location = "Paphos";
          };
        };

        dashboard = {
          directories.enabled = false;
          stats.enable_gpu = true;
          powermenu = {
            avatar = {
              image = "${./profile-pic.jpg}";
              name = "Anton";
            };
          };
          shortcuts = {
            left = {
              shortcut1 = {
                icon = "";
                tooltip = "Firefox";
                command = "zen";
              };
            };
          };
        };

        power.lowBatteryThreshold = 15;
      };

      theme = {
        bar.transparent = false;

        font = {
          # label = "Inter";
          size = "16px";
        };
      };
    };
  };

  specialisation.light.configuration = {
    programs.hyprpanel.theme = "catppuccin_latte";
  };
}
