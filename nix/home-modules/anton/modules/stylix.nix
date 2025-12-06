{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  stylix = {
    enable = true;

    image = lib.mkDefault config.backgrounds."metheora-mocha.jpg";
    base16Scheme = lib.mkDefault "${inputs.base16-schemes}/catppuccin-mocha.yaml";

    targets = {
      zed.enable = false;
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
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        terminal = 11;
      };
    };
  };

  catppuccin = {
    enable = true;
    flavor = lib.mkDefault "mocha";
    accent = lib.mkDefault "sky";
  };
}
