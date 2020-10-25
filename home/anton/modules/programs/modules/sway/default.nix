{ pkgs, config, lib, inputs, ... }@input:
# let swayPackage = pkgs.waylandPkgs.sway-unwrapped;
let swayPackage = pkgs.sway;
in with config.lib.base16.theme; {

  imports = [ ./keybinds.nix ];

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
      systemctl --user import-environment \
        DBUS_SESSION_BUS_ADDRESS DISPLAY SSH_AUTH_SOCK XAUTHORITY \
        XDG_DATA_DIRS XDG_RUNTIME_DIR XDG_SESSION_ID \
        GDK_PIXBUF_ICON_LOADER GDK_PIXBUF_MODULE_FILE PATH
      exec sway
    end
  '';

  wayland.windowManager.sway = {
    enable = true;
    #package = swayPackage;

    extraConfig = ''
      exec mako
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

      seat seat0 xcursor_theme Qogir 32
    '';

    config = let cfg = config.wayland.windowManager.sway;
    in {
      bars = [ ];

      terminal = "${pkgs.alacritty}/bin/alacritty";

      menu = "wofi -I --show drun";

      workspaceAutoBackAndForth = true;

      colors = {
        focused = {
          background = "#${base00-hex}";
          text = "#${base05-hex}";
          border = "#${base0C-hex}";
          childBorder = "#${base0D-hex}";
          indicator = "#${base0F-hex}";
        };
        focusedInactive = {
          background = "#${base00-hex}";
          text = "#${base05-hex}";
          border = "#${base03-hex}";
          childBorder = "#${base04-hex}";
          indicator = "#${base05-hex}";
        };
        unfocused = {
          background = "#${base00-hex}";
          text = "#${base05-hex}";
          border = "#${base00-hex}";
          childBorder = "#${base01-hex}";
          indicator = "#${base03-hex}";
        };
      };

      startup = [
        { command = "wl-paste -t text --watch clipman store"; }
        { command = "wl-paste -p -t text --watch clipman store -P --histpath='~/.local/share/clipman-primary.json'"; }
        {
          command =
            "systemctl --user restart network-manager-applet blueman-applet udiskie";
          always = true;
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

      assigns = {
        "1" = [ { app_id = "^firefox$"; } { class = "^Firefox$"; }];
        "2" = [ { app_id = "^emacs$"; } { class = "^Emacs$"; } ];
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

      fonts = [ "${fontUIName} ${fontUISize}" ];

      output = { "*" = { bg = "${../../../../backgrounds/tree.jpg} fill"; }; };

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
}
