{ config, lib, pkgs, ... }:

{
  services.thermald.enable = true;

  systemd.services.thermald.serviceConfig.ExecStart = lib.mkForce (''
    ${pkgs.thermald}/sbin/thermald \
                --no-daemon \
                --dbus-enable \
                --ignore-cpuid-check \
                --config-file ${./thermal-conf.xml.auto}
                --adaptive
  '');
}
