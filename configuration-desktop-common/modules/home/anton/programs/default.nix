{ pkgs, config, ... }: {
  imports = builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  services = {
    network-manager-applet.enable = config.wayland.windowManager.sway.enable;
    blueman-applet.enable = config.wayland.windowManager.sway.enable;
    nextcloud-client.enable = config.wayland.windowManager.sway.enable;
    udiskie.enable = config.wayland.windowManager.sway.enable;
  };
}
