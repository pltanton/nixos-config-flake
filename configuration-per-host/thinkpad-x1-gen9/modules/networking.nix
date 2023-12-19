{ config, lib, pkgs, ... }:

{
  networking.nameservers = [ "8.8.8.8" "1.1.1.1" ];

  networking.extraHosts = ''
    127.0.0.1 db
    127.0.0.1 db-user-service
    127.0.0.1 zookeeper
    127.0.0.1 trap-server
    127.0.0.1 kafka
  '';

  systemd.services.ModemManager.enable = true;

}
