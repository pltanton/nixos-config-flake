{ lib, pkgs, config, ... }: {
  programs.alacritty.enable = true;
  programs.alacritty.settings = { font = { size = 17; }; };
}
