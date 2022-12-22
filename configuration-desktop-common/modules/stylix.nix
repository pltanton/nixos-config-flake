{ pkgs, inputs, ... }: {
  stylix = {
    base16Scheme = "${inputs.base16-schemes}/catppuccin.yaml";
    image = ./home/backgrounds/nord-1.jpg;
    targets.swaylock.enable = false;
  };
}
