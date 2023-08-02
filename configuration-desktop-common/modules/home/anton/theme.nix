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
    pkgs.qogir-theme
    pkgs.qogir-icon-theme
    pkgs.gnome-icon-theme
    pkgs.hicolor-icon-theme
    pkgs.papirus-icon-theme
    pkgs.gnome.adwaita-icon-theme
    pkgs.nordic

    (pkgs.catppuccin-gtk.override {
      accents = [ "pink" ];
      size = "compact";
      tweaks = [ "rimless" ];
      variant = "macchiato";
    })
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
      package = pkgs.nordic;
      name = "Catppuccin-Macchiato-Compact-Pink-dark";
    };
    iconTheme = {
      package = pkgs.kora-icon-theme;
      name = "kora";
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
    size = 32;
    x11.enable = false;
    gtk.enable = tilingWM;
  };
}
