{ pkgs, config, lib, inputs, ... }@input:
let
  # swayPackage = pkgs.waylandPkgs.sway-unwrapped;
  # swayPackage = pkgs.master.sway;
  swayPackage = pkgs.sway-unwrapped;
  # swayPackage = pkgs.sway.overrideAttrs (soldAttrs: {
  #   src = pkgs.fetchFromGitHub {
  #     owner = "RPigott";
  #     repo = "sway";
  #     rev = "54e3c4969835c7af1e83eeb8d3051fae8aabb3fc";
  #     hash = "sha256-HjLxiCTt+EI8+UzJzNvAgw/5m3Ynj/yu1HMxoXGUzlo=";
  #   };
  # });
in with config.lib.base16.theme; {

  services.keyboardLayoutPerWindow.enable =
    config.wayland.windowManager.sway.enable;

  services.flashfocus.enable = config.wayland.windowManager.sway.enable;
  services.clipman.enable = config.wayland.windowManager.sway.enable;
  services.wob.enable = config.wayland.windowManager.sway.enable;

  imports =
    [ ./keybinds.nix ./inputs.nix ./delay-systemd-service.nix ./services ];

  home.packages = lib.mkIf config.wayland.windowManager.sway.enable
    (with pkgs; [
      wl-clipboard
      swayidle
      clipman
      grim
      swaybg
      slurp

      swaylock-fancy
      flashfocus

      wofi-emoji
    ]);

  programs.fish.loginShellInit =
    lib.mkIf config.wayland.windowManager.sway.enable ''
      set TTY1 (tty)
      if test -z "$DISPLAY"; and test $TTY1 = "/dev/tty1"
        exec sh -c '${swayPackage}/bin/sway; systemctl --user stop sway-session.target; systemctl --user stop graphical-session.target'
      end
    '';

  home.sessionVariables = lib.mkIf config.wayland.windowManager.sway.enable {
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
    # MOZ_ENABLE_WAYLAND = 1;
    _JAVA_AWT_WM_NONREPARENTING = 1;
    GDK_PIXBUF_MODULE_FILE =
      "${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";

    WLR_DRM_NO_MODIFIERS = 1;

    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";

    # WOBSOCK = "$XDG_RUNTIME_DIR/wob.sock";
  };

  wayland.windowManager.sway = {
    enable = true;
    package = swayPackage;
    systemdIntegration = true;
    wrapperFeatures = {
      gtk = true;
      base = true;
    };

    extraConfig = ''
      exec mako
      exec swayidle -w \
               timeout 300 'lock' \
               timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
               before-sleep 'lock'
      # exec swayidle -w \
      #   timeout 300 'lock' \
      #   timeout 315 'swaymsg "output * dpms off"' \
      #   resume 'swaymsg "output * dpms on"'

      workspace 1 output DP-1
      workspace 2 outpu DP-1
      workspace 3 output DP-1
      workspace 4 output DP-1

      workspace 9 output DP-1
      workspace "im" output eDP-1

      seat * xcursor_theme ${cursorTheme} 32
      seat * hide_cursor 4000
      seat * hide_cursor when-typing enable

      exec systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
      exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK

      set $gnome-schema org.gnome.desktop.interface
      exec_always {
          ${pkgs.glib}/bin/gsettings set $gnome-schema gtk-theme '${gtkTheme}'
          ${pkgs.glib}/bin/gsettings set $gnome-schema icon-theme '${iconTheme}'
          ${pkgs.glib}/bin/gsettings set $gnome-schema cursor-theme '${cursorTheme}'
          ${pkgs.glib}/bin/gsettings set $gnome-schema text-scaling-factor 1.6
          ${pkgs.glib}/bin/gsettings set $gnome-schema font-name '${fontUIName} 11'
      }
    '';

    config = let cfg = config.wayland.windowManager.sway;
    in {
      bars = [ ];

      terminal = "${pkgs.alacritty}/bin/alacritty";

      menu = "wofi --show drun -I";

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
          border = "#${base0E-hex}";
          childBorder = "#${base01-hex}";
          indicator = "#${base03-hex}";
        };
      };

      startup = [
        {
          command = "${pkgs.xsettingsd}/bin/xsettingsd";
        }
        # { command = "wl-paste -t text --watch clipman store"; }
        # {
        #   command =
        #     "wl-paste -p -t text --watch clipman store -P --histpath='~/.local/share/clipman-primary.json'";
        # }
        {
          command = "systemctl --user restart kanshi";
          always = true;
        }
        { command = "firefox"; }
        { command = "thunderbird"; }
        { command = "telegram-desktop"; }
        { command = "slack"; }
        {
          command = "keyctl link @u @s";
        }
        # {
        #   command =
        #     "exec ${pkgs.master.autotiling}/bin/autotiling -w 2 3 4 5 6 7 9 0";
        # }
      ];

      assigns = {
        "1" = [ { app_id = "^firefox$"; } { class = "^Firefox$"; } ];
        "2" = [ { app_id = "^emacs$"; } { class = "^Emacs$"; } ];
        "8" = [ { app_id = "^thunderbird"; } { class = "^Thunderbird"; } ];
        "9" = [{ class = "^Spotify$"; }];

        "im" = [ { app_id = "^telegramdesktop$"; } { class = "^Slack$"; } ];
      };

      window = {
        border = 3;
        commands = [
          {
            criteria = { title = "Firefox — Sharing Indicator"; };
            command = "kill";
          }
          {
            criteria = {
              class = "^Steam$";
              title = "^(?!Steam$)";
            };
            command = "floating enable";
          }
          {
            criteria = { app_id = "^telegramdesktop$"; };
            command = "resize set width 1 ppt";
          }
          {
            criteria = { app_id = "^com.nextcloud.desktopclient.nextcloud$"; };
            command = "floating enable; move position cursor";
          }
          {
            criteria = { title = "^org.inkscape.Inkscape$"; };
            command = "floating enable";
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

      fonts = {
        names = [ "${fontUIName}" ];
        size = 16.0;
      };

      output = {
        "*" = { bg = "${../../../../backgrounds/nord-1.jpg} fill"; };
      };
    };
  };
}
