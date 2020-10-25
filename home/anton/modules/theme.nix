{ pkgs, ... }:
let
  themeConsts = {
    fontConsoleName = "Iosevka Term";
    fontConsoleSize = "19";
    fontUIName = "Inter";
    fontUISize = "16";
    # iconTheme = "Qogir-dark";
    iconTheme = "Paper-Mono-Dark";
    gtkTheme = "Qogir-dark";
    cursorTheme = "Qogir";
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
      # package = pkgs.qogir-icon-theme;
      package = pkgs.paper-icon-theme;
      name = themeConsts.iconTheme;
    };
    gtk3.extraConfig.gtk-cursor-theme-name = themeConsts.cursorTheme;
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
  };

  home.file.".icons/default/index.theme".text = ''
    [icon theme]
    Inherits=${themeConsts.cursorTheme}
  '';

  xsession.pointerCursor = {
    package = pkgs.qogir-icon-theme;
    name = "Qogir";
    size = 32;
  };
}
