{ pkgs, config, lib, inputs, ... }:
let
  scripts = import ./scripts pkgs config;
  cfg = config.wayland.windowManager.sway;

  grabScreenshot = pkgs.writeShellScript "grabScreenshot" ''
    mkdir -p ~/Screenshots
    FILE_PATH=~/Screenshots/shot_$(date +"%y%m%d%H%M%S").png
    grim -g "$(slurp)" - | swappy -f - -o "$FILE_PATH"
    wl-copy -t image/png < $FILE_PATH
  '';

  rofiWindowsSwitch = pkgs.writeShellScript "rofiWindowsSwitch" ''
    windows=$(swaymsg -t get_tree | ${pkgs.jq}/bin/jq -r 'recurse(.nodes[]?)|recurse(.floating_nodes[]?)|select(.type=="con"),select(.type=="floating_con")|(.id|tostring)+" "+.app_id+": "+.name')

    selected=$(echo "$windows" | rofi -dmenu -i | awk '{print $1}')

    # Tell sway to focus said window
    swaymsg [con_id="$selected"] focus
  '';
in {
  wayland.windowManager.sway = {
    config = {

      modifier = "Mod4";

      bindkeysToCode = true;

      keybindings = lib.mkOptionDefault {
        "${cfg.config.modifier}+Shift+Return" = "exec ${cfg.config.terminal}";
        "${cfg.config.modifier}+Shift+c" = "kill";
        # Fade out
        # "${cfg.config.modifier}+Shift+c" =
        #   "mark quit; exec ${scripts}/bin/fadeout";
        "${cfg.config.modifier}+Shift+r" = "reload";
        # "${cfg.config.modifier}+Return" = "exec ${cfg.config.menu}";

        #################
        ##### ROFI ######
        #################

        "${cfg.config.modifier}+backslash" =
          "exec ${inputs.bwmenu.defaultPackage.x86_64-linux}/bin/bwmenu --rofi";
        "${cfg.config.modifier}+Return" = "exec rofi -show drun -show-icons";
        "${cfg.config.modifier}+semicolon" = "exec ${rofiWindowsSwitch}";
        "Print" = "exec ${grabScreenshot}";
        "${cfg.config.modifier}+Shift+v" = "exec clipman pick -t rofi";
        "${cfg.config.modifier}+v" = "exec rofi-vpn";
        "${cfg.config.modifier}+Shift+e" = "exec rofi -show emoji -modi emoji";
        "${cfg.config.modifier}+Shift+q" =
          "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'systemctl --user stop graphical-session.target; systemctl --user stop sway-session.target; swaymsg exit'";

        "${cfg.config.modifier}+Shift+l" = "exec lock";

        "XF86AudioRaiseVolume" =
          "exec ${pkgs.pamixer}/bin/pamixer --get-volume -ui 5 > $WOBSOCK";
        "XF86AudioLowerVolume" =
          "exec ${pkgs.pamixer}/bin/pamixer --get-volume -ud 5 > $WOBSOCK";
        "XF86AudioMute" =
          "exec ${pkgs.pamixer}/bin/pamixer --toggle-mute && ((${pkgs.pamixer}/bin/pamixer --get-mute && echo 0) || ${pkgs.pamixer}/bin/pamixer --get-volume) | tail -n 1 > $WOBSOCK ";

        "XF86MonBrightnessUp" =
          "exec ${scripts}/bin/brightness --inc -d 5 | head -n 1 > $WOBSOCK";
        "XF86MonBrightnessDown" =
          "exec ${scripts}/bin/brightness --dec -d 5 | head -n 1 > $WOBSOCK";

        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
        "XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

        # "${cfg.config.modifier}+y" = "workspace next_on_output";
        # "${cfg.config.modifier}+p" = "workspace prev_on_output";

        "${cfg.config.modifier}+tab" = "workspace im";
        "${cfg.config.modifier}+shift+tab" = "move container to workspace im";

        "${cfg.config.modifier}+Shift+comma" = "move workspace to output left";
        "${cfg.config.modifier}+Shift+apostrophe" =
          "move workspace to output right";
        "${cfg.config.modifier}+Shift+period" = "move workspace to output down";
        "${cfg.config.modifier}+Shift+p" = "move workspace to output up";
        "${cfg.config.modifier}+comma" = "focus output left";
        "${cfg.config.modifier}+apostrophe" = "focus output right";
        "${cfg.config.modifier}+period" = "focus output down";
        "${cfg.config.modifier}+p" = "focus output up";

        "${cfg.config.modifier}+n" = "mode mako";

        "${cfg.config.modifier}+Shift+a" = "focus child";

        "${cfg.config.modifier}+Shift+s" = "sticky togge";

        "${cfg.config.modifier}+x" = "mode layout";

        # "${cfg.config.modifier}+Shift+Left" = "nop move left";
        # "${cfg.config.modifier}+Shift+Right" = "nop move right";
        # "${cfg.config.modifier}+Shift+Up" = "nop move up";
        # "${cfg.config.modifier}+Shift+Down" = "nop move down";

        # "${cfg.config.modifier}+f" = "nop fullscreen";
        # "${cfg.config.modifier}+space" = "nop promote_window";

        # "${cfg.config.modifier}+j" = "nop focus_naext_window";
        # "${cfg.config.modifier}+k" = "nop focus_prev_window";

        # "${cfg.config.modifier}+Shift+j" = "nop swap_with_next_window";
        # "${cfg.config.modifier}+Shift+k" = "nop swap_with_prev_window";
      };

      keycodebindings = lib.mkOptionDefault { };

      modes = let makoctl = "${pkgs.mako}/bin/makoctl";
      in lib.mkOptionDefault {
        mako = {
          Escape = "mode default";
          "Shift+d" = "exec ${makoctl} dismiss --all; mode default";
          "Shift+x" = "exec ${makoctl} dismiss --group";
          "Shift+i" =
            "exec ${makoctl} menu rofi -d -p 'Chose action:'; mode default;";
          "Return" =
            "exec ${makoctl} invoke; exec ${makoctl} dismiss; mode default";
          "d" = "exec ${makoctl} dismiss";
        };
        # layout = {
        #   Escape = "mode default";
        #   Return = "mode default";
        #   "t" = "nop set_layout tall";
        #   "3" = "nop set_layout 3_col";
        #   "n" = "nop set_layout nop";
        #   "i" = "nop increment_masters";
        #   "d" = "nop decrement_masters";
        #   "x" = "nop reflect_x";
        #   "y" = "nop reflect_y";
        #   "z" = "nop transpose";

        #   "Shift+t" = "layout tabbed";
        # };
      };
    };
  };
}
