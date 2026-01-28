{
  pkgs,
  lib,
  config,
  ...
}: {
  catppuccin = {
    enable = true;
    flavor = lib.mkDefault "mocha";
    accent = lib.mkDefault "sky";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-GTK-Sky-Dark";
      package = pkgs.magnetic-catppuccin-gtk.override {
        accent = [config.catppuccin.accent];
        tweaks = [];
      };
    };
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
