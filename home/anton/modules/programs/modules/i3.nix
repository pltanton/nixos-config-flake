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
  xsession.windowManager.i3 = {
    enable = true;

    config = let
      modifier = "Mod4";
    in {
      bars = [ ];
      workspaceAutoBackAndForth = true;
      modifier = modifier;

      startup = [
        {
          command = "${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.clipman}/bin/clipman store";
        }
        { command = "firefox"; }
        { command = "emacs"; }
        { command = "telegram-desktop"; }
        { command = "slack"; }
      ];

      keybindings = lib.mkOptionDefault {
        "${modifier}+Shift+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+Shift+c" = "kill";
        "${modifier}+Shift+r" = "reload";
        "${modifier}+Return" = "exec ${pkgs.wofi}/bin/rofi -show drun";
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

      assigns = {
        "1" = [{ class = "^firefox$"; }];
        "2" = [{ class = "^Emacs$"; }];
        "9" = [{ class = "^Spotify$"; }];

        "im" = [ { class = "^telegramdesktop$"; } { class = "^Slack$"; } ];
      };

      window = {
        commands = [
          {
            criteria = { class = "^telegramdesktop$"; };
            command = "resize set width 1 ppt";
          }
          {
            criteria = {
              class = "^telegramdesktop$";
              title = "^Media viewer$";
            };
            command = "floating enable";
          }
          {
            criteria = {
              class = "^telegramdesktop$";
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
    };
  };
}
