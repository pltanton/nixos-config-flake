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

  systemd.user.services.network-manager-applet.Service.ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
  systemd.user.services.ubdiskie.Service.ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
  systemd.user.services.pasystray.Service.ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
  systemd.user.services.blueman-applet.Service.ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";

}
