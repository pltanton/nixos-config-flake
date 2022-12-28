{ pkgs, inputs, ... }: {
  stylix = {
    base16Scheme = "${inputs.base16-schemes}/nord.yaml";
    image = ./home/backgrounds/nord-1.jpg;
    targets.swaylock.enable = false;

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
        package = pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; };
        name = "Iosevka";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
