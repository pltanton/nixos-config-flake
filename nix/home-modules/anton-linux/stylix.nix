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
      gnome.enable = false;

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
      enable = false;
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
  };

  catppuccin = {
    enable = false;
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
}
