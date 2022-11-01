{ pkgs, config, lib, ... }:
let
  themeConsts = {
    fontConsoleName = "Iosevka";
    fontConsoleSize = "17";
    fontUIName = "Inter";
    fontUISize = "15";
    # iconTheme = "Adwaita";
    # iconTheme = "Qogir-dark";
    iconTheme = "Papirus-Dark";
    gtkTheme = "Nordic-bluish-accent";
    # gtkTheme = "Adwaita-dark";
    # cursorTheme = "Qogir-dark";
    # cursorTheme = "Adwaita";
    cursorTheme = "phinger-cursors";
    cursorSize = 32;
  };
  tilingWM = true && (config.wayland.windowManager.sway.enable
    || config.wayland.windowManager.hyprland.enable);
in {
  home.packages = [
    pkgs.qogir-theme
    pkgs.qogir-icon-theme
    pkgs.gnome-icon-theme
    pkgs.hicolor-icon-theme
    pkgs.papirus-icon-theme
    pkgs.master.phinger-cursors
    pkgs.gnome.adwaita-icon-theme
  ];
  themes.base16 = {
    enable = true;
    scheme = "nord";
    variant = "nord";
    # scheme = "gruvbox";
    # variant = "gruvbox-dark-hard";
    extraParams = themeConsts;
  };

  gtk = {
    enable = tilingWM;
    theme = {
      # package = pkgs.qogir-theme;
      package = pkgs.nordic;
      name = themeConsts.gtkTheme;
    };
    iconTheme = {
      # package = pkgs.numix-icon-theme;
      # package = pkgs.qogir-icon-theme;
      package = pkgs.papirus-icon-theme;
      # package = pkgs.gnome3.adwaita-icon-theme;
      name = themeConsts.iconTheme;
    };
    # gtk3.extraConfig.gtk-cursor-theme-name = themeConsts.cursorTheme;
    # gtk3.extraConfig.gtk-cursor-theme-size = themeConsts.cursorSize;
    # gtk4.extraConfig.gtk-cursor-theme-name = themeConsts.cursorTheme;
    # gtk4.extraConfig.gtk-cursor-theme-size = themeConsts.cursorSize;
    # gtk4.extraConfig.gtk-prefer-dark-theme = 1;
  };

  qt = {
    enable = tilingWM;
    platformTheme = "gtk";
  };

  # home.file.".icons/default/index.theme".text = ''
  #   [icon theme]
  #   Inherits=${themeConsts.cursorTheme}
  # '';

  home.pointerCursor = lib.mkIf tilingWM {
    package = pkgs.qogir-icon-theme;
    name = themeConsts.cursorTheme;
    size = themeConsts.cursorSize;
    x11.enable = tilingWM;
    gtk.enable = tilingWM;
  };

  home.sessionVariables = {
    XCURSOR_THEME = themeConsts.cursorTheme;
    XCURSOR_SIZE = themeConsts.cursorSize;
  };
}
