{ pkgs, config, lib, inputs, ... }:
let
  themeConsts = rec {
    fontConsoleName = "Iosevka";
    fontConsoleSize = "17";
    fontUIName = "Inter";
    fontUISize = "15";

    gtkTheme = "Nordic-bluish-accent";

    gradient0 = "8fbcbb";
    gradient1 = "88c0d0";
    gradient2 = "81a1c1";
    gradient3 = "5e81ac";
  };
  # tilingWM = true && (config.wayland.windowManager.sway.enable
  # || config.wayland.windowManager.hyprland.enable);
  tilingWM = true;
in {
  home.packages = [
    pkgs.gnome-icon-theme
    pkgs.hicolor-icon-theme
    pkgs.gnome.adwaita-icon-theme
    pkgs.catppuccin-kde
  ];
  # themes.base16 = {
  #   enable = true;
  #   scheme = "nord";
  #   variant = "nord";
  #   extraParams = themeConsts;
  # };

  gtk = {
    enable = tilingWM;
    theme = {
      package =

        (pkgs.catppuccin-gtk.override {
          accents = [ "pink" ];
          size = "compact";
          tweaks = [ "rimless" ];
          variant = "macchiato";
        });
      name = "Catppuccin-Macchiato-Compact-Pink-dark";
    };
    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "macchiato";
        accent = "green";
      };
      name = "Papirus-Dark";
    };
    gtk2.extraConfig = ''
      gtk-font-name = "Inter 30";
      font_name = "Inter 30";
      gtk-cursor-theme-size = 64;
    '';
  };

  qt = {
    enable = tilingWM;
    platformTheme = "gtk";
  };

  home.pointerCursor = lib.mkIf tilingWM {
    package = pkgs.master.phinger-cursors;
    name = "phinger-cursors-light";
    # package = pkgs.catppuccin-cursors.macchiatoDark;
    # name = "Catppuccin-Macchiato-Dark-Cursors";
    size = 32;
    x11.enable = false;
    gtk.enable = tilingWM;
  };
}
