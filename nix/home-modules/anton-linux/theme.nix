{pkgs, lib, ...}: {
  gtk.enable = true;
  gtk.theme = {
    name = "adw-gtk3-dark";
    package = pkgs.adw-gtk3;
  };
  gtk.iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };

  xdg.configFile = {
    "gtk-3.0/gtk.css".text = ''
      @import url("file:///home/anton/.config/gtk-3.0/dank-colors.css");
    '';
    "gtk-4.0/gtk.css".text = ''
      @import url("file:///home/anton/.config/gtk-4.0/dank-colors.css");
    '';
    "qt5ct/qt5ct.conf".text = ''
      [Appearance]
      icon_theme=Papirus-Dark
    '';
    "qt6ct/qt6ct.conf".text = ''
      [Appearance]
      icon_theme=Papirus-Dark
    '';
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  home.pointerCursor = {
    package = pkgs.phinger-cursors;
    name = lib.mkDefault "phinger-cursors-dark";
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = lib.mkDefault "prefer-dark";
    };
  };
}
