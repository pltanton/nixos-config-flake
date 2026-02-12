{
  pkgs,
  config,
  lib,
  ...
}: lib.mkIf config.wayland.windowManager.hyprland.enable {
  xdg.portal = {
    extraPortals = lib.mkAfter [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
