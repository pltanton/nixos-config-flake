{ pkgs, config, lib, ... }@input: {
  programs.eww = with config.lib.base16.theme; {
    package = pkgs.eww-wayland;
    enable = false && config.wayland.windowManager.hyprland.enable;
    configDir = ./config/bar;
  };
}
