{ pkgs, config, lib, inputs, ... }:
let
  tilingWM = true;
in {
  xfconf.enable = lib.mkForce false;

  home.packages = [
    pkgs.gnome-icon-theme
    pkgs.hicolor-icon-theme
    pkgs.gnome.adwaita-icon-theme
    pkgs.catppuccin-kde
  ];

  gtk = {
    enable = tilingWM;
    # theme = gtkTheme;
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

  # xdg.configFile = {
  #   "gtk-4.0/assets".source = "${gtkThemeDir}/gtk-4.0/assets";
  #   "gtk-4.0/gtk.css".source = "${gtkThemeDir}/gtk-4.0/gtk.css";
  #   "gtk-4.0/gtk-dark.css".source = "${gtkThemeDir}/gtk-4.0/gtk-dark.css";
  #  };

  qt = {
    enable = tilingWM;
    platformTheme = "gtk";
  };

  # home.pointerCursor = lib.mkIf tilingWM {
  #   package = pkgs.master.phinger-cursors;
  #   name = "phinger-cursors-light";
  #   # package = pkgs.catppuccin-cursors.macchiatoDark;
  #   # name = "Catppuccin-Macchiato-Dark-Cursors";
  #   size = 32;
  #   x11.enable = false;
  #   gtk.enable = tilingWM;
  # };
}
