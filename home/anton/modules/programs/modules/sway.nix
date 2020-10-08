{ pkgs, config, lib, inputs, ... }:
let
  grabScreenshot = pkgs.writeShellScript "grabScreenshot" ''
    FILE_PATH=~/screenshots/shot_$(date +"%y%m%d%H%M%S").png
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" $FILE_PATH
    ${pkgs.wl-clipboard}/bin/wl-copy < $FILE_PATH
  '';

  wofiWindowsSwitch = pkgs.writeShellScript "wofiWindowsSwitch" ''
    windows=$(${pkgs.sway}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -r 'recurse(.nodes[]?)|recurse(.floating_nodes[]?)|select(.type=="con"),select(.type=="floating_con")|(.id|tostring)+" "+.app_id+": "+.name')

    selected=$(echo "$windows" | wofi --dmenu -i | awk '{print $1}')

    # Tell sway to focus said window
    ${pkgs.sway}/bin/swaymsg [con_id="$selected"] focus
  '';
in {
  xsession.windowManager.sway = {
    enable = true;

    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';

    extraConfig = ''
      exec ${pkgs.swayidle}/bin/swayidle -w \
        timeout 300 'lock' \
        timeout 315 '${pkgs.sway}/bin/swaymsg "output * dpms off"' \
        resume '${pkgs.sway}/bin/swaymsg "output * dpms on"' \
        after-resume '${pkgs.sway}/bin/swaymsg "output * dpms on"' \
        before-sleep 'lock'

      workspace 1 output DP-1
      workspace 2 output DP-1
      workspace 3 output DP-1

      workspace "im" output eDP-1
    '';

    config = let
      copyCommand = with pkgs; "${grip} -g ";
      modifier = config.wayland.windowManager.sway.config.modifier;
      cfg = config.wayland.windowManager.sway;
    in {
      bars = [ ];
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "${pkgs.wofi}/bin/wofi --show drun";
      workspaceAutoBackAndForth = true;

      modifier = "Mod4";

      startup = [
        {
          command = "${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.clipman}/bin/clipman store";
        }
        {
          command = "systemctl --user restart waybar";
          always = true;
        }
        {
          command = "systemctl --user restart kanshi";
          always = true;
        }
        { command = "firefox"; }
        { command = "emacs"; }
        { command = "telegram-desktop"; }
        { command = "slack"; }
      ];

      keybindings = lib.mkOptionDefault {
        "${modifier}+Shift+Return" = "exec ${cfg.config.terminal}";
        "${modifier}+Shift+c" = "kill";
        "${modifier}+Shift+r" = "reload";
        "${modifier}+Return" = "exec ${cfg.config.menu}";
        "${modifier}+semicolon" = "exec ${wofiWindowsSwitch}";
        "Print" = "exec ${grabScreenshot}";
        "${modifier}+Insert" =
          "exec ${pkgs.clipman}/bin/clipman pick -t wofi";

        "${modifier}+Shift+l" = "exec lock";

        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 5";
        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 5";
        "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
        "XF86MonBrightnessUp" = "exec light -A 20";
        "XF86MonBrightnessDown" = "exec light -U 20";

        "${modifier}+y" = "workspace next_on_output";
        "${modifier}+p" = "workspace prev_on_output";

        "${modifier}+tab" = "workspace im";
        "${modifier}+shift+tab" = "move container to workspace im";

        "${modifier}+Shift+comma" = "move workspace to output left";
        "${modifier}+Shift+apostrophe" = "move workspace to output right";
        "${modifier}+comma" = "focus output left";
        "${modifier}+apostrophe" = "focus output right";
      };

      keycodebindings = lib.mkOptionDefault { };

      assigns = {
        "1" = [{ app_id = "^firefox$"; }];
        "2" = [{ class = "^Emacs$"; }];
        "9" = [{ class = "^Spotify$"; }];

        "im" = [ { app_id = "^telegramdesktop$"; } { class = "^Slack$"; } ];
      };

      window = {
        commands = [
          {
            criteria = { app_id = "^telegramdesktop$"; };
            command = "resize set width 1 ppt";
          }
          {
            criteria = {
              app_id = "^telegramdesktop$";
              title = "^Media viewer$";
            };
            command = "floating enable";
          }
          {
            criteria = {
              app_id = "^telegramdesktop$";
              title = "Choose";
            };
            command = "resize set 1100 700";
          }
          {
            criteria = { class = "^Slack$"; };
            command = "resize set 4 width ppt";
          }
        ];
      };

      gaps = {
        inner = 5;
        smartGaps = false;
        smartBorders = "on";
      };

      output = { "*" = { bg = "${../../../backgrounds/tree.jpg} fill"; }; };

      input = {
        "1:1:AT_Translated_Set_2_keyboard" = {
          xkb_layout = "us,ru";
          xkb_variant = "dvorak,";
          xkb_options = "grp:caps_toggle";
        };

        "51984:16982:Keebio_Keebio_Iris_Rev._4" = {
          xkb_layout = "us,ru";
          xkb_variant = ",";
          xkb_options = "grp:caps_toggle";
        };
      };
    };
  };

  programs.mako = with config.lib.base16.theme; {
    enable = true;
    font = "${fontUIName} ${fontUISize}";
    backgroundColor = "#${base01-hex}D9";
    borderColor = "#${base01-hex}";
    textColor = "#${base05-hex}";
    groupBy = "app-name";
    width = 500;
    height = 800;
  };
}
