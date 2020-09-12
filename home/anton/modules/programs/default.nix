{ pkgs, ... }:
{
  imports = builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  programs = {
    firefox.enable = true;
  };

  services = {
    status-notifier-watcher.enable = true;
    network-manager-applet.enable = true;
    udiskie.enable = true;
    pasystray.enable = true;
    blueman-applet.enable = true;
    unclutter.enable = true;
    gnome-keyring.enable = true;
    nextcloud-client.enable = true;
    mpd.enable = true;
  };
}
