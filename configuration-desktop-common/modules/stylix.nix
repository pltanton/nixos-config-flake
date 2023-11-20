{ config, pkgs, inputs, lib, ... }: {
  stylix = {
    base16Scheme = "${inputs.base16-schemes}/catppuccin-macchiato.yaml";
    # base16Scheme = "${inputs.base16-schemes}/nord.yaml";
    image = ./home/backgrounds/evening-sky.png;

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
    };
  };
}
