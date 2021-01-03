{ pkgs, config, lib, ... }:
let
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

        "${cfg.config.modifier}+Shift+l" = "exec lock";

        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 5";
        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 5";
        "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
        "XF86MonBrightnessUp" = "exec light -A 10";
        "XF86MonBrightnessDown" = "exec light -U 10";

        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play";
        "XF86AudioStop" = "exec ${pkgs.playerctl}/bin/playerctl pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

        "${cfg.config.modifier}+f12" = "exec ${pkgs.bitwarden-rofi}/bin/bwmenu";

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
