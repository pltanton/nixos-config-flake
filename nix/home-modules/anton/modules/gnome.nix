{
  pkgs,
  config,
  lib,
  ...
}: let
  enable = true;
in
  lib.mkIf enable {
    programs.gnome-shell = {
      enable = true;
      extensions = with pkgs.gnomeExtensions; [
      ];
    };

    dconf = {
      enable = true;
      settings = {
        # "org/gnome/desktop/background" = {
        #   picture-uri-dark = lib.mkForce "file://${config.backgrounds."metheora-mocha.jpg"}";
        #   picture-uri = lib.mkForce "file://${config.backgrounds."metheora.jpg"}";
        # };

        "org/gnome/mutter" = {
          experimental-features = ["scale-monitor-framebuffer"];
        };

        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = with pkgs.gnomeExtensions;
            map (e: e.extensionUuid) [
              gsconnect
              tiling-shell
              clipboard-history
              cloudflare-warp-toggle
              hot-edge
              mouse-follows-focus
              quick-lang-switch
              caffeine
              smile-complementary-extension
              quick-settings-tweaker
            ];
        };
      };
    };

    home = {
      packages = with pkgs; [
        gnome-browser-connector
      ];

      sessionVariables = {
        NIXOS_OZONE_WL = 1;
        GDK_BACKEND = "wayland,x11";
        GTK_USE_PORTAL = 1;
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_QPA_PLATFORMTHEME = "gtk3";
        SDL_VIDEODRIVER = "wayland";
        ANKI_WAYLAND = 1;
      };
    };
  }
