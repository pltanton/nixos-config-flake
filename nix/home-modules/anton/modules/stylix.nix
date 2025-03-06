{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  stylix = {
    enable = true;

    image = config.backgrounds."van-chilling.png";
    base16Scheme = "${inputs.base16-schemes}/catppuccin-mocha.yaml";

    targets = {
      firefox.enable = false;
      swaylock.enable = false;
      rofi.enable = false;
      waybar.enable = false;
      avizo.enable = false;
      vscode.enable = false;
      hyprland.enable = false;
      hyprlock.enable = false;
      bemenu.enable = false;
      alacritty.enable = false;
      zed.enable = false;
    };

    polarity = lib.mkDefault "dark";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
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
    flavor = "mocha";
    accent = "sky";

    rofi.enable = false;
    kvantum.enable = false;
  };
}
