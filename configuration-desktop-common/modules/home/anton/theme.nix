{ pkgs, ... }:
let
  themeConsts = {
    fontConsoleName = "Iosevka";
    fontConsoleSize = "19";
    fontUIName = "Inter";
    fontUISize = "16";
    # iconTheme = "Adwaita";
    iconTheme = "Qogir-dark";
    # iconTheme = "Papirus-dark";
    gtkTheme = "Nordic-bluish-accent";
    # gtkTheme = "Adwaita-dark";
    # cursorTheme = "Qogir-dark";
    cursorTheme = "phinger-cursors";
    cursorSize = 32;
  };
in {
  home.packages = [
    pkgs.qogir-theme
    pkgs.qogir-icon-theme
    pkgs.gnome-icon-theme
    pkgs.hicolor-icon-theme
    pkgs.master.phinger-cursors
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
    enable = true;
    theme = {
      # package = pkgs.qogir-theme;
      package = pkgs.nordic;
      name = themeConsts.gtkTheme;
    };
    iconTheme = {
      package = pkgs.numix-icon-theme;
      # package = pkgs.qogir-icon-theme;
      # package = pkgs.papirus-icon-theme;
      # package = pkgs.gnome3.adwaita-icon-theme;
      name = themeConsts.iconTheme;
    };
    gtk3.extraConfig.gtk-cursor-theme-name = themeConsts.cursorTheme;
    gtk3.extraConfig.gtk-cursor-theme-size = themeConsts.cursorSize;
    gtk4.extraConfig.gtk-cursor-theme-name = themeConsts.cursorTheme;
    gtk4.extraConfig.gtk-cursor-theme-size = themeConsts.cursorSize;
  };

  # qt = {
  #   enable = true;
  #   platformTheme = "gtk";
  # };

  # home.file.".icons/default/index.theme".text = ''
  #   [icon theme]
  #   Inherits=${themeConsts.cursorTheme}
  # '';

  xsession.pointerCursor = {
    package = pkgs.qogir-icon-theme;
    name = themeConsts.cursorTheme;
    size = themeConsts.cursorSize;
  };
}
