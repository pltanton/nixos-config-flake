{ pkgs, ... }: {
  services = {
    network-manager-applet.enable = tilingEnabled;
    blueman-applet.enable = tilingEnabled;
    nextcloud-client.enable = false;
    udiskie.enable = tilingEnabled;
    clipman.enable = false;
    ddcsync.enable = tilingEnabled;
  };
}
