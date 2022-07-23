{ pkgs, config, lib, ... }@input: {
  programs.eww = with config.lib.base16.theme; {
    package = pkgs.eww-wayland;
    enable = false && config.wayland.windowManager.sway.enable;
    configDir = ./config;
  };
}
