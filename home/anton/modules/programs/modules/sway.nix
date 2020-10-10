{ pkgs, config, lib, inputs, ... }@input:
let
  swayPackage = pkgs.waylandPkgs.sway-unwrapped;
  grabScreenshot = pkgs.writeShellScript "grabScreenshot" ''
    FILE_PATH=~/Screenshots/shot_$(date +"%y%m%d%H%M%S").png
    grim -g "$(slurp)" $FILE_PATH
    wl-copy -t image/png < $FILE_PATH
  '';

  wofiWindowsSwitch = pkgs.writeShellScript "wofiWindowsSwitch" ''
    windows=$(${swayPackage}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -r 'recurse(.nodes[]?)|recurse(.floating_nodes[]?)|select(.type=="con"),select(.type=="floating_con")|(.id|tostring)+" "+.app_id+": "+.name')

    selected=$(echo "$windows" | wofi --dmenu -i | awk '{print $1}')

    # Tell sway to focus said window
    ${swayPackage}/bin/swaymsg [con_id="$selected"] focus
  '';
in {

  home.packages = with pkgs; [
    waylandPkgs.wl-clipboard
    waylandPkgs.wl-clipboard
    waylandPkgs.swayidle
    waylandPkgs.clipman
    waylandPkgs.waybar
    waylandPkgs.wofi
    waylandPkgs.grim
    waylandPkgs.swaybg
    waylandPkgs.slurp
  ];

  programs.fish.loginShellInit = ''
    export SDL_VIDEODRIVER=wayland
    export QT_QPA_PLATFORM=wayland
    export CLUTTER_BACKEND=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1

    set TTY1 (tty)
    if test -z "$DISPLAY"; and test $TTY1 = "/dev/tty1"
      exec sway
    end
  '';

  wayland.windowManager.sway = {
    enable = true;
    #package = swayPackage;

    extraConfig = ''
      exec swayidle -w \
        timeout 300 'lock' \
        timeout 315 'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
        after-resume 'swaymsg "output * dpms on"' \
        before-sleep 'lock'

      workspace 1 output DP-1
      workspace 2 output DP-1
      workspace 3 output DP-1
      workspace 4 output DP-1

      workspace 9 output DP-1
      workspace "im" output eDP-1
    '';

    config = let
      modifier = config.wayland.windowManager.sway.config.modifier;
      cfg = config.wayland.windowManager.sway;
    in {
      bars = [
        # {
        #   command = "waybar";
        # }
      ];
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "wofi --show drun";
      workspaceAutoBackAndForth = true;

      modifier = "Mod4";

      startup = [
        {
          command = "wl-paste -t text --watch clipman store";
        }
        {
          command = "systemctl --user start nextcloud-client";
          always = true;
        }
        {
          command = "systemctl --user restart waybar";
          always = true;
        }
        {
          command = "systemctl --user restart blueman-applet network-manager-applet nextcloud-client";
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
          "exec clipman pick -t wofi";

        "${modifier}+Shift+l" = "exec lock";

        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 5";
        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 5";
        "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
        "XF86MonBrightnessUp" = "exec light -A 10";
        "XF86MonBrightnessDown" = "exec light -U 10";

        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
        "XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

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
        "2" = [{ app_id = "^emacs$"; }];
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
