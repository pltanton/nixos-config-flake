{ config, pkgs, ... }:

{
  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = { allowedUDPPorts = [ 51820 ]; };

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.10.10.1/24" ];
      listenPort = 51820;
      privateKeyFile = "/root/nixos/wgkey";
      peers = [{
        allowedIPs = [ "10.10.10.10/32" ]; # Home server
        publicKey = "8AEkjWAMTQg20MKLY6GHqLO5y9pWm4rTVOugKs8FpQk=";
      }];
    };
  };
}