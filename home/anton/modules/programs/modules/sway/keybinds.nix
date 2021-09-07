{ pkgs, config, lib, inputs, ... }:
let
  scripts = import ./scripts pkgs;
  cfg = config.wayland.windowManager.sway;

  grabScreenshot = pkgs.writeShellScript "grabScreenshot" ''
    FILE_PATH=~/Screenshots/shot_$(date +"%y%m%d%H%M%S").png
    grim -g "$(slurp)" $FILE_PATH
    wl-copy -t image/png < $FILE_PATH
  '';

  wofi = "${pkgs.waylandPkgs.wofi}/bin/wofi";
  rofi = "${pkgs.rofi}/bin/rofi";

  wofiWindowsSwitch = pkgs.writeShellScript "wofiWindowsSwitch" ''
    windows=$(${cfg.package}/bin/swaymsg -t get_tree | ${pkgs.jq}/bin/jq -r 'recurse(.nodes[]?)|recurse(.floating_nodes[]?)|select(.type=="con"),select(.type=="floating_con")|(.id|tostring)+" "+.app_id+": "+.name')

    selected=$(echo "$windows" | ${wofi} --dmenu -i | awk '{print $1}')

    # Tell sway to focus said window
    ${cfg.package}/bin/swaymsg [con_id="$selected"] focus
  '';

  wobWrapper = pkgs.writeShellScript "wobWrapper" ''
    # returns 0 (success) if $1 is running and is attached to this sway session; else 1
    is_running_on_this_screen() {
        pkill -0 $1 || return 1
        for pid in $( pgrep $1 ); do
            WOB_SWAYSOCK="$( tr '\0' '\n' < /proc/$pid/environ | awk -F'=' '/^SWAYSOCK/ {print $2}' )"
            if [[ "$WOB_SWAYSOCK" == "$SWAYSOCK" ]]; then
                return 0
            fi
        done
        return 1
    }

    new_value=$1 # null or a percent; no checking!!

    wob_pipe=~/.cache/$( basename $SWAYSOCK ).wob

    [[ -p $wob_pipe ]] || mkfifo $wob_pipe

    # wob does not appear in $(swaymsg -t get_msg), so:
    is_running_on_this_screen wob || {
        tail -f $wob_pipe | ${pkgs.wob}/bin/wob &
    }

    [[ "$new_value" ]] && echo $new_value > $wob_pipe
  '';
in {
  wayland.windowManager.sway = {
    config = {
      modifier = "Mod4";

      bindkeysToCode = true;

      keybindings = lib.mkOptionDefault {
        "${cfg.config.modifier}+Shift+Return" = "exec ${cfg.config.terminal}";
        "${cfg.config.modifier}+Shift+c" = "kill";
        "${cfg.config.modifier}+Shift+r" = "reload";
        "${cfg.config.modifier}+Return" = "exec ${cfg.config.menu}";
        "${cfg.config.modifier}+semicolon" = "exec ${wofiWindowsSwitch}";
        "Print" = "exec ${grabScreenshot}";
        "${cfg.config.modifier}+Shift+v" = "exec clipman pick -t wofi";

        "${cfg.config.modifier}+Shift+a" = "exec wofi-emoji";

        "${cfg.config.modifier}+Shift+l" = "exec lock";

        "XF86AudioRaiseVolume" =
          "exec ${pkgs.pamixer}/bin/pamixer -ui 5 && ${wobWrapper} $(${pkgs.pamixer}/bin/pamixer --get-volume)";
        "XF86AudioLowerVolume" =
          "exec ${pkgs.pamixer}/bin/pamixer -ud 5 && ${wobWrapper} $(${pkgs.pamixer}/bin/pamixer --get-volume)";
        "XF86AudioMute" =
          "exec ${pkgs.pamixer}/bin/pamixer --toggle-mute && ${wobWrapper} $(( ${pkgs.pamixer}/bin/pamixer --get-mute && echo 0 > $SWAYSOCK.wob ) || ${pkgs.pamixer}/bin/pamixer --get-volume)";

        "XF86MonBrightnessUp" =
          "exec ${wobWrapper} $(${scripts.brightness}/bin/brightness --inc -d 5)";
          # "exec ${pkgs.light}/bin/light -A 5 && ${wobWrapper} $(light -G | cut -d'.' -f1) && ${pkgs.ddcutil}/bin/ddcutil setvcp 10 $(light -G | cut -d'.' -f1)";
        "XF86MonBrightnessDown" =
          "exec ${wobWrapper} $(${scripts.brightness}/bin/brightness --dec -d 5)";
          # "exec ${pkgs.light}/bin/light -U 5 && light -G | ${wobWrapper} $(cut -d'.' -f1) && ${pkgs.ddcutil}/bin/ddcutil setvcp 10 $(light -G | cut -d'.' -f1)";

        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
        "XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

        "${cfg.config.modifier}+backslash" = "exec ${inputs.bwmenu.defaultPackage.x86_64-linux}/bin/bwmenu";

        "${cfg.config.modifier}+y" = "workspace next_on_output";
        "${cfg.config.modifier}+p" = "workspace prev_on_output";

        "${cfg.config.modifier}+tab" = "workspace im";
        "${cfg.config.modifier}+shift+tab" = "move container to workspace im";

        "${cfg.config.modifier}+Shift+comma" = "move workspace to output left";
        "${cfg.config.modifier}+Shift+apostrophe" =
          "move workspace to output right";
        "${cfg.config.modifier}+comma" = "focus output left";
        "${cfg.config.modifier}+apostrophe" = "focus output right";

        "${cfg.config.modifier}+n" = "mode mako";
      };

      keycodebindings = lib.mkOptionDefault { };

      modes = let makoctl = "${pkgs.mako}/bin/makoctl";
      in lib.mkOptionDefault {
        mako = {
          Escape = "mode default";
          "Shift+d" = "exec ${makoctl} dismiss --all; mode default";
          "Shift+x" = "exec ${makoctl} dismiss --group";
          "Shift+i" =
            "exec ${makoctl} menu ${wofi} -d -p 'Chose action:'; mode default;";
          "Return" =
            "exec ${makoctl} invoke; exec ${makoctl} dismiss; mode default";
          "d" = "exec ${makoctl} dismiss";
        };
      };
    };
  };
}
