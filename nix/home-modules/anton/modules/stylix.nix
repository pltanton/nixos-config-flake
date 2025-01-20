{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  stylix = {
    enable = true;

    image = config.backgrounds."unsplash-mountains.jpg";
    base16Scheme = lib.mkDefault "${inputs.base16-schemes}/catppuccin-mocha.yaml";

    targets.firefox.enable = false;
    targets.swaylock.enable = false;
    targets.rofi.enable = false;
    targets.waybar.enable = false;
    targets.avizo.enable = false;
    targets.vscode.enable = false;
    targets.hyprland.enable = false;
    targets.bemenu.enable = false;
    targets.alacritty.enable = false;
    targets.zed.enable = false;

    polarity = lib.mkDefault "dark";
    cursor = {
      # package = pkgs.master.phinger-cursors;
      # name = lib.mkDefault "phinger-cursors-light";
      package = pkgs.bibata-cursors;
      name = lib.mkDefault "Bibata-Modern-Classic";
      size = 24;
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
        # package = pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; };
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

  catppuccin = {
    enable = true;
    flavor = lib.mkDefault "mocha";
    accent = "sky";

    rofi.enable = false;
    kvantum.enable = false;
  };



  # specialisation.light.configuration = {
  #   stylix = {
  #     base16Scheme = "${inputs.base16-schemes}/catppuccin-latte.yaml";
  #     polarity = "light";
  #     # cursor.name = "phinger-cursors";
  #   };

  #   catppuccin = {
  #     flavor = "latte";
  #   };
  # };
}
