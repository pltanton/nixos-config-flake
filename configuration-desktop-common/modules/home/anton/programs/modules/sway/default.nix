{ pkgs, config, lib, inputs, ... }@input:
let swayPackage = pkgs.sway-unwrapped;
in with config.lib.base16.theme; {
  services.keyboardLayoutPerWindow.enable =
    config.wayland.windowManager.sway.enable;
  services.flashfocus.enable = false
    && config.wayland.windowManager.sway.enable;
  services.swaymonad.enable = false && config.wayland.windowManager.sway.enable;
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
      slurp
      swappy

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
    GDK_PIXBUF_MODULE_FILE =
      "${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";

    QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;

    WLR_DRM_NO_ATOMIC = "1";
    # WLR_NO_HARDWARE_CURSORS = "1";

    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";

    WLR_DRM_NO_MODIFIERS = 1;
  };

  wayland.windowManager.sway = {
    enable = true;
    package = swayPackage;
    systemdIntegration = true;
    wrapperFeatures = {
      gtk = true;
      base = true;
    };

    extraSessionCommands = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
    '';

    extraConfig = let borderImage = ./assets/border.png;
    in ''
      exec mako
      exec swayidle -w \
               timeout 300 'lock' \
               timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
               before-sleep 'lock'

      workspace 1 output DP-1
      workspace 2 outpu DP-1
      workspace 3 output DP-1
      workspace 4 output DP-1

      workspace 9 output DP-1
      workspace "im" output eDP-1

      seat * xcursor_theme ${cursorTheme} ${toString cursorSize} 
      seat * hide_cursor 4000
      seat * hide_cursor when-typing enable

      # border_images.unfocused ${borderImage}
      # border_images.focused ${borderImage}
      # border_images.focused_inactive ${borderImage}
      # border_images.urgent ${borderImage}

      exec systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
      exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK

      set $gnome-schema org.gnome.desktop.interface
      exec_always {
          ${pkgs.glib}/bin/gsettings set $gnome-schema gtk-theme '${gtkTheme}'
          ${pkgs.glib}/bin/gsettings set $gnome-schema icon-theme '${iconTheme}'
          ${pkgs.glib}/bin/gsettings set $gnome-schema cursor-theme '${cursorTheme}'
          ${pkgs.glib}/bin/gsettings set $gnome-schema cursor-size '${
            toString cursorSize
          }'
          ${pkgs.glib}/bin/gsettings set $gnome-schema text-scaling-factor 1.2
          ${pkgs.glib}/bin/gsettings set $gnome-schema font-name '${fontUIName} 11'
      }
    '';

    config = let cfg = config.wayland.windowManager.sway;
    in {
      bars = [ ];
      terminal = "alacritty";
      menu = "wofi --show drun -I";

      workspaceAutoBackAndForth = true;

      colors = {
        focused = {
          background = "#${base0D-hex}";
          text = "#${base00-hex}";
          border = "#${base0D-hex}";
          childBorder = "#${base0D-hex}";
          indicator = "#${base0F-hex}";
        };
        focusedInactive = {
          background = "#${base0D-hex}";
          text = "#${base00-hex}";
          border = "#${base03-hex}";
          childBorder = "#${base00-hex}";
          indicator = "#${base00-hex}";
        };
        unfocused = {
          background = "#${base00-hex}";
          text = "#${base05-hex}";
          border = "#${base00-hex}";
          childBorder = "#${base00-hex}";
          indicator = "#${base00-hex}";
        };
      };

      startup = [
        { command = "${pkgs.xsettingsd}/bin/xsettingsd"; }
        {
          command = "systemctl --user restart kanshi";
          always = true;
        }
        { command = "firefox"; }
        { command = "thunderbird-wayland"; }
        { command = "telegram-desktop"; }
        {
          command =
            "mattermost-desktop --ozone-platform=wayland --enable-features=UseOzonePlatform";
        }
        { command = "keyctl link @u @s"; }
        {
          command =
            "exec ${pkgs.master.autotiling}/bin/autotiling -w 2 3 4 5 6 7 9 0";
          always = true;
        }
      ];

      assigns = {
        "1" = [
          { app_id = "^firefox$"; }
          { class = "^Firefox$"; }
          { class = "^firefox-default$"; }
        ];
        "2" = [ { app_id = "^emacs$"; } { class = "^Emacs$"; } ];
        "8" = [ { app_id = "^thunderbird"; } { class = "^Thunderbird"; } ];
        "9" = [{ class = "^Spotify$"; }];

        "im" = [
          { app_id = "^telegramdesktop$"; }
          { title = "^Mattermost Desktop App$"; }
        ];
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
            criteria = {
              app_id = "darktable";
              window_type = "floating_con";
            };
            command = "move position cursor";
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
          # {
          #   criteria = {
          #     app_id = "^telegramdesktop$";
          #     title = "^Media viewer$";
          #   };
          #   command = "floating enable";
          # }
          {
            criteria = {
              app_id = "^telegramdesktop$";
              title = "Choose";
            };
            command = "resize set 1100 700";
          }
          {
            criteria = {
              app_id = "^telegramdesktop$";
              title = "^Telegram.*";
            };
            command = "resize set width 33 ppt";
          }
          {
            criteria = { title = "^Mattermost Desktop App$"; };
            command = "resize set width 67 ppt";
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
        "*" = { bg = "${../../../../backgrounds/nord-5.png} fill"; };
      };
    };
  };
}
