{ config, lib, pkgs, ... }:

{
  systemd.services.thermald.serviceConfig.ExecStart = lib.mkForce (''
    ${pkgs.thermald}/sbin/thermald \
                --no-daemon \
                --dbus-enable \
                --ignore-cpuid-check \
                --adaptive
  '');
  services.thermald = { enable = true; };
}
