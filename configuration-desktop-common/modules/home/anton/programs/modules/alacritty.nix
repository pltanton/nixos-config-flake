{ lib, pkgs, config, ... }: {
  programs.alacritty.enable = true;
  programs.alacritty.settings.font.size = lib.mkForce 14;
}
