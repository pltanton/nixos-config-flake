{ pkgs, config, lib, ... }: let
  grabScreenshot = pkgs.writeShellScript "grapScreenshot" ''
    FILE_PATH=~/screenshots/shot_$(date +"%y%m%d%H%M%S").png
    ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" $FILE_PATH
    ${pkgs.wl-clipboard}/bin/wl-copy < $FILE_PATH
  '';

in {
  wayland.windowManager.sway = {
    enable = true;

    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';

    config = let
      copyCommand = with pkgs; "${grip} -g ";
    in {
      bars = [];
      terminal = "${pkgs.kitty}/bin/kitty";
      menu = "${pkgs.rofi}/bin/rofi -show drun -show-icons -columns 2";
      modifier = "Mod4";
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        cfg = config.wayland.windowManager.sway;
      in lib.mkOptionDefault {
        "${modifier}+Shift+Return" = "exec ${cfg.config.terminal}";
        "${modifier}+Shift+c" = "kill";
        "${modifier}+Return" = "exec ${cfg.config.menu}";
        "Print" = "exec ${grabScreenshot}";
        "${modifier}+Insert" =
          "exec ${pkgs.rofi}/bin/rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'";
        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 5";
        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 5";
        "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";
      };

      gaps = {
        outer = 5;
        inner = 5;
        smartGaps = true;
        smartBorders = "on";
      };

      output = {
        "*" = {
          bg = "${../../../backgrounds/body-of-water-near-mountains.jpg} fill";
        };
      };

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
    backgroundColor = "#${base01-hex}FF";
    width = 800;
    height = 400;
  };
}
