{ config, lib, pkgs, ... }:

{
  networking.networkmanager.enableFccUnlock = true;
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  networking.extraHosts = ''
    127.0.0.1 db
    127.0.0.1 zookeeper
    127.0.0.1 trap-server
  '';

  systemd.services.ModemManager.enable = true;

}