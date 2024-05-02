{pkgs, ...}: {
  services = {
    network-manager-applet.enable = true;
    blueman-applet.enable = true;
    nextcloud-client.enable = false;
    udiskie.enable = true;
    ddcsync.enable = true;
  };
}
