{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  # xdg.dataFile."home-manager/specialisation".text = "";

  stylix = {
    enable = true;

    image = lib.mkDefault config.backgrounds."metheora-mocha.jpg";
    base16Scheme = lib.mkDefault "${inputs.base16-schemes}/catppuccin-mocha.yaml";
    polarity = lib.mkDefault "dark";

    targets = {
      gtk.enable = true;
      gnome.enable = true;

      # In most cases integration is disabled
      # if have catppuccin implementation
      spicetify.enable = false;
      firefox.enable = false;
      swaylock.enable = false;
      swaync.enable = false;
      rofi.enable = false;
      waybar.enable = false;
      avizo.enable = false;
      vscode.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      bemenu.enable = false;
      alacritty.enable = false;
      zed.enable = false;
      ghostty.enable = false;
      fish.enable = false;
    };

    iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };

    # cursor = {
    #   package = pkgs.bibata-cursors;
    #   name = "Bibata-Modern-Classic";
    #   size = 24;

    # };
    cursor = {
      package = pkgs.phinger-cursors;
      # name = lib.mkDefault "phinger-cursors-dark";
      name = lib.mkDefault "phinger-cursors-light";
      size = 32;
    };

    fonts = {
      serif = {
        package = pkgs.inter;
        name = "Inter";
      };

      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };

      monospace = {
        package = pkgs.monaspace;
        name = "Monaspace Argon";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        terminal = 14;
      };
    };
  };

  programs.hyprcursor-phinger.enable = true;

  catppuccin = {
    enable = true;
    flavor = lib.mkDefault "mocha";
    accent = lib.mkDefault "sky";

    # rofi.enable = false;
    # kvantum.enable = false;
    zed.enable = false;
    # ghostty.enable = false;
  };

  # dconf = {
  #   enable = true;
  #   settings = {
  #     "org/gnome/desktop/interface".color-scheme = lib.mkDefault "prefer-dark";
  #   };
  # };

  home.packages = [
    (lib.lowPrio (pkgs.writeShellApplication {
      name = "theme-toggle";
      runtimeInputs = with pkgs; [home-manager coreutils ripgrep fish];
      text = ''
        "$(home-manager generations | head -1 | rg -o '/[^ ]*')"/specialisation/light/activate -b bak
        fish --command 'set -U _reload_theme (date +%s)'
      '';
    }))
  ];

  specialisation.light.configuration = {
    xdg.dataFile."home-manager/specialisation".text = "light";

    stylix = {
      base16Scheme = "${inputs.base16-schemes}/catppuccin-latte.yaml";
      image = config.backgrounds."metheora.jpg";
      polarity = "light";

      # cursor = {
      #   name = "phinger-cursors-light";
      # };
    };

    catppuccin = {
      flavor = "latte";
      accent = "sky";
      # waybar.flavor = "mocha";
      hyprlock.flavor = "mocha";
    };

    home.packages = [
      (pkgs.writeShellApplication {
        name = "theme-toggle";
        runtimeInputs = with pkgs; [home-manager coreutils ripgrep fish];
        text = ''
          "$(home-manager generations | head -2 | tail -1 | rg -o '/[^ ]*')"/activate -b bak
          fish --command 'set -U _reload_theme (date +%s)'
        '';
      })
    ];

    # dconf = {
    #   settings = {
    #     "org/gnome/desktop/interface".color-scheme = "prefer-light";
    #   };
    # };
  };
}
