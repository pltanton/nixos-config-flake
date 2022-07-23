{ pkgs, config, ... }: {
  services.tlp.enable = !config.services.xserver.desktopManager.gnome.enable;
}
