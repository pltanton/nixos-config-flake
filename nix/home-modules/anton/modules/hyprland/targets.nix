{
  config,
  lib,
  ...
}: let
  shouldEnable = config.wayland.windowManager.hyprland.enable;
  targetOverride =
    lib.mkIf shouldEnable {systemdTarget = "graphical-session.target";};
in {
  services.kanshi = targetOverride;
}
