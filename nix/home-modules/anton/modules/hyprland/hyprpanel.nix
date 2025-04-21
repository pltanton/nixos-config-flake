{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.hyprpanel.homeManagerModules.hyprpanel];

  xdg.configFile.hyprpanel.force = true;

  programs.hyprpanel = {
    enable = true;
    systemd.enable = true;
    hyprland.enable = true;
    overwrite.enable = true;

    settings = {
      scalingPriority = "both";

      bar.launcher.autoDetectIcon = true;
      bar.workspaces.show_icons = true;

      theme = {
        name = lib.mkDefault "catppuccin_mocha";
        bar = {
          transparent = false;
          floating = true;
          margin_sides = "15px";
          dropdownGap = "45px";
          buttons = {
            y_margins = "0.3em";
            padding_x = "0.5rem";
            padding_y = "0.15rem";
            radius = "0.8em";
            spacing = "0.15em";
          };
        };

        font = {
          name = "Inter";
          size = "14px";
        };
      };

      layout = {
        "bar.layouts" = {
          "*" = {
            left = ["dashboard" "workspaces" "kbinput"];
            middle = ["windowtitle"];
            right = ["systray" "volume" "network" "bluetooth" "clock" "notifications" "battery"];
          };
        };
      };

      bar = {
        workspaces = {
          numbered_active_indicator = "highlight";
          showApplicationIcons = true;
          showWsIcons = true;
        };

        customModules = {
          hypridle = {
            label = false;
          };
        };
        network = {
          rightClick = "nm-connection-editor";
          label = false;
        };

        bluetooth = {
          label = false;
        };

        clock = {
          format = "%H:%M";
          showIcon = false;
        };
      };

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
    };
  };

  specialisation.light.configuration = {
    programs.hyprpanel.settings.theme.name = "catppuccin_latte";
  };
}
