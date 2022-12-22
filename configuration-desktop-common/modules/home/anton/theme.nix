{ pkgs, config, lib, inputs, ... }:
let
  themeConsts = rec {
    fontConsoleName = "Iosevka";
    fontConsoleSize = "17";
    fontUIName = "Inter";
    fontUISize = "15";
    # iconTheme = "Adwaita";
    # iconTheme = "Qogir-dark";
    iconPackage = pkgs.papirus-icon-theme;
    iconTheme = "Papirus-Dark";
    gtkTheme = "Nordic-bluish-accent";
    # gtkTheme = "Adwaita-dark";
    # cursorTheme = "Qogir-dark";
    # cursorTheme = "Adwaita";
    cursorTheme = "phinger-cursors";
    cursorSize = 32;
    cursorSizeX2 = cursorSize * 2;

    gradient0 = "8fbcbb";
    gradient1 = "88c0d0";
    gradient2 = "81a1c1";
    gradient3 = "5e81ac";
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
    pkgs.nordic
  ];
  # themes.base16 = {
  #   enable = true;
  #   scheme = "nord";
  #   variant = "nord";
  #   extraParams = themeConsts;
  # };

  gtk = {
    enable = tilingWM;
    # theme = {
    #   package = pkgs.nordic;
    #   # name = themeConsts.gtkTheme;
    # };
    iconTheme = {
      package = themeConsts.iconPackage;
      name = themeConsts.iconTheme;
    };
    # gtk3.extraConfig.gtk-cursor-theme-name = themeConsts.cursorTheme;
    # gtk3.extraConfig.gtk-cursor-theme-size = themeConsts.cursorSize;
    # gtk4.extraConfig.gtk-cursor-theme-name = themeConsts.cursorTheme;
    # gtk4.extraConfig.gtk-cursor-theme-size = themeConsts.cursorSize;
    # gtk4.extraConfig.gtk-prefer-dark-theme = 1;
  };

  qt = {
    #    enable = tilingWM;
    #    platformTheme = "gtk";
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

  home.sessionVariables = lib.mkIf tilingWM {
    XCURSOR_THEME = themeConsts.cursorTheme;
    XCURSOR_SIZE = themeConsts.cursorSize;
  };
}
