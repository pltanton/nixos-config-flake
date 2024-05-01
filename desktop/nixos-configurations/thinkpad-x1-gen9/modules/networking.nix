{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "thinkpad-x1-gen9";

    nameservers = [ "8.8.8.8" "1.1.1.1" ];

    extraHosts = ''
      127.0.0.1 db
      127.0.0.1 db-user-service
      127.0.0.1 zookeeper
      127.0.0.1 trap-server
      127.0.0.1 kafka
    '';
  };
}
