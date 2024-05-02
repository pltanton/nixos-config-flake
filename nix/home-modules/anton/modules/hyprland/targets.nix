{
  pkgs,
  config,
  lib,
  ...
}: let
  shouldEnable = config.wayland.windowManager.hyprland.enable;
  targetOverride =
    lib.mkIf shouldEnable {systemdTarget = "hyprland-session.target";};
in {
  services.kanshi = targetOverride;
  services.wlsunset = targetOverride;
}
