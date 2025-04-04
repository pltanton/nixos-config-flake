{
  pkgs,
  inputs,
  lib,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = lib.mkDefault "mocha";
  };

  specialisation.light.configuration = {
    programs.spicetify.colorScheme = "latte";
  };
}
