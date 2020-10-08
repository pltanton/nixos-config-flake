{ pkgs, ... }:
{
  imports = builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  programs = {
    firefox.enable = true;
  };

  services = {
    status-notifier-watcher.enable = false;
    network-manager-applet.enable = true;
    udiskie.enable = false;
    pasystray.enable = false;
    blueman-applet.enable = true;
    unclutter.enable = false;
    gnome-keyring.enable = true;
    nextcloud-client.enable = false;
    mpd.enable = false;
  };
}
