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
    nerd-fonts.space-mono
    inter
    sketchybar-app-font
  ];
  programs.sketchybar = {
    enable = false;
    extraPackages = [
      config.programs.aerospace.package
      pkgs.jq
      pkgs.flock
    ];
    configType = "lua";
    config = {
      source = ./config-lua;
      recursive = true;
    };
  };
}
