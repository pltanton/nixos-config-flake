{pkgs, ...}: {
  services.greetd = {
    enable = false;
    settings = {
      terminal.vt = 1;
      default_session.command =
        "${pkgs.greetd.tuigreet}/bin/tuigreet --time "
        + "--remember --remember-user-session ";
    };
  };

  # programs.regreet = {
  #   enable = true;
  #   cageArgs = [ "-s" "-m" "last" ];
  #   settings = {
  #     background = {
  #       path = config.stylix.image;
  #       fit = "Fill";
  #     };

  #     GTK = {
  #       cursor_theme_name = config.stylix.cursor.name;
  #       icon_theme_name = "kora";
  #       theme_name = "Catppuccin-Macchiato-Compact-Lavender-Dark";
  #     };
  #   };
  # };

  environment.systemPackages = [
    pkgs.kora-icon-theme
    (pkgs.catppuccin-gtk.override {
      accents = ["lavender"];
      size = "compact";
      tweaks = ["rimless"];
      variant = "macchiato";
    })
  ];
}
