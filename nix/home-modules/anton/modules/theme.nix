{
  pkgs,
  lib,
  ...
}: {
  xfconf.enable = lib.mkForce false;

  # home.packages = [
  #   (lib.lowPrio (pkgs.writeShellApplication {
  #     name = "toggle-theme";
  #     runtimeInputs = with pkgs; [home-manager coreutils ripgrep fish];
  #     text = ''
  #       "$(home-manager generations | head -1 | ${pkgs.ripgrep}/bin/rg -o '/[^ ]*')"/specialisation/light/activate
  #       fish --command 'set -U _reload_theme (date +%s)'
  #     '';
  #   }))
  # ];

  gtk = {
    enable = true;

    iconTheme = {
      package = pkgs.kora-icon-theme;
      name = "kora";
    };

    gtk2.extraConfig = ''
      gtk-font-name = "Inter 30";
      font_name = "Inter 30";
      gtk-cursor-theme-size = 64;
    '';

    # theme = lib.mkDefault {
    #   name = "Catppuccin-Macchiato-Standard-Maroon-Dark";
    #   package = pkgs.catppuccin-gtk.override {
    #     accents = ["maroon"];
    #     size = "standard";
    #     tweaks = ["normal"];
    #     variant = "macchiato";
    #   };
    # };
  };

  qt = {
    enable = true;
    # platformTheme.name = "gtk";
  };

  specialisation.light.configuration = {
    home.packages = [
      (pkgs.writeShellApplication {
        name = "toggle-theme";
        runtimeInputs = with pkgs; [home-manager coreutils ripgrep fish];
        text = ''
          "$(home-manager generations | head -2 | tail -1 | rg -o '/[^ ]*')"/activate
          fish --command 'set -U _reload_theme (date +%s)'
        '';
      })
    ];
  };
}
