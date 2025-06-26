{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.blex-mono
    nerd-fonts.iosevka
    inter
  ];
  programs.sketchybar = {
    enable = true;
    extraPackages = [pkgs.aerospace];
    config = {
      source = ./config;
      recursive = true;
    };
  };
}
