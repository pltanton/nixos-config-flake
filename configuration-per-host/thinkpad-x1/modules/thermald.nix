{ config, lib, pkgs, ... }:

{
  systemd.services.thermald.serviceConfig.ExecStart = lib.mkForce (''
    ${pkgs.thermald}/sbin/thermald \
                --no-daemon \
                --dbus-enable \
                --ignore-cpuid-check \
                --adaptive
  '');
  services.thermald.enable.enable =
    !config.services.xserver.desktopManager.gnome.enable
    && !config.services.xserver.desktopManager.plasma5.enable;
}
