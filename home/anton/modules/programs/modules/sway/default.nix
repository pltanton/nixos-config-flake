{ pkgs, config, lib, inputs, ... }@input:
let swayPackage = pkgs.waylandPkgs.sway-unwrapped;
# let swayPackage = pkgs.sway;
in with config.lib.base16.theme; {

  imports = [ ./keybinds.nix ./inputs.nix ./delay-systemd-service.nix ];

  home.packages = with pkgs.waylandPkgs; [
    wl-clipboard
    swayidle
    clipman
    waybar
    grim
    swaybg
    slurp
    pkgs.swaylock-fancy
  ];

  programs.fish.loginShellInit = ''
    set TTY1 (tty)
    if test -z "$DISPLAY"; and test $TTY1 = "/dev/tty1"
      exec sway
    end
  '';

  home.sessionVariables = {
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      _JAVA_AWT_WM_NONREPARENTING = 1;
      GDK_PIXBUF_MODULE_FILE = "${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";
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
        timeout 315 'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
        before-sleep 'lock'

      workspace 1 output DP-1
      workspace 2 output DP-1
      workspace 3 output DP-1
      workspace 4 output DP-1

      workspace 9 output DP-1
      workspace "im" output eDP-1

      seat seat0 xcursor_theme Qogir-dark 32

      exec systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
      exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK

      set $gnome-schema org.gnome.desktop.interface
      exec_always {
          gsettings set $gnome-schema gtk-theme '${gtkTheme}'
          gsettings set $gnome-schema icon-theme '${iconTheme}'
          gsettings set $gnome-schema cursor-theme '${cursorTheme}'
          gsettings set $gnome-schema text-scaling-factor 1.6
          gsettings set $gnome-schema font-name '${fontUIName} 11'
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
        { command = "{pkgs.xsettingsd}/bin/xsettingsd"; }
        { command = "wl-paste -t text --watch clipman store"; }
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
      ];

      assigns = {
        "1" = [ { app_id = "^firefox$"; } { class = "^Firefox$"; } ];
        "2" = [ { app_id = "^emacs$"; } { class = "^Emacs$"; } ];
        "8" = [{ class = "^Thunderbird"; }];
        "9" = [{ class = "^Spotify$"; }];

        "im" = [ { app_id = "^telegramdesktop$"; } { class = "^Slack$"; } ];
      };

      window = {
        border = 3;
        commands = [
          {
            criteria = { app_id = "^telegramdesktop$"; };
            command = "resize set width 1 ppt";
          }
          {
            criteria = { app_id = "^com.nextcloud.desktopclient.nextcloud$"; };
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

      fonts = [ "${fontUIName} ${fontUISize}" ];

      output = {
        "*" = { bg = "${../../../../backgrounds/death-stranding-1.jpg} fill"; };
      };
    };
  };
}
