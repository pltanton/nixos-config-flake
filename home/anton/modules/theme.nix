{ pkgs, ... }:
let
  themeConsts = {
    fontConsoleName = "Iosevka Term";
    fontConsoleSize = "19";
    fontUIName = "Inter";
    fontUISize = "16";
    iconTheme = "Qogir-dark";
    # iconTheme = "Papirus";
    gtkTheme = "Qogir-dark";
    cursorTheme = "Qogir-dark";
  };
in {
  home.packages = [ pkgs.qogir-icon-theme ];
  themes.base16 = {
    enable = true;
    scheme = "onedark";
    variant = "onedark";
    extraParams = themeConsts;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.qogir-theme;
      name = themeConsts.gtkTheme;
    };
    iconTheme = {
      package = pkgs.qogir-icon-theme;
      # package = pkgs.papirus-icon-theme;
      name = themeConsts.iconTheme;
    };
    gtk3.extraConfig.gtk-cursor-theme-name = themeConsts.cursorTheme;
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  # home.file.".icons/default/index.theme".text = ''
  #   [icon theme]
  #   Inherits=${themeConsts.cursorTheme}
  # '';

  xsession.pointerCursor = {
    package = pkgs.qogir-icon-theme;
    name = themeConsts.cursorTheme;
    size = 32;
  };
}
