{ pkgs, config, ... }:
let
  tilingEnabled = (config.wayland.windowManager.sway.enable
    || config.wayland.windowManager.hyprland.enable);
in {

  imports = builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  services = {
    network-manager-applet.enable = tilingEnabled;
    blueman-applet.enable = tilingEnabled;
    nextcloud-client.enable = false;
    udiskie.enable = tilingEnabled;
    clipman.enable = false;
    ddcsync.enable = tilingEnabled;
  };
}
