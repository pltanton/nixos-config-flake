{ pkgs, ... }:
{
  systemd.user.services.network-manager-applet.Service.ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
  systemd.user.services.ubdiskie.Service.ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
  systemd.user.services.nextcloud-client.Service.ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
  systemd.user.services.blueman-applet.Service.ExecStartPre = "${pkgs.coreutils}/bin/sleep 2";
  # systemd.user.services.waybar.Service.ExecStartPre = "${pkgs.coreutils}/bin/sleep 1";
}
