{ config, pkgs, ... }:

{
  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.nat.externalInterface = "ens3";
  networking.firewall = { allowedUDPPorts = [ 51820 ]; };

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.10.10.1/24" ];
      listenPort = 51820;
      privateKeyFile = "/root/nixos/wgkey";
      peers = [
        {
          allowedIPs = [ "10.10.10.10/32" ]; # Home server
          publicKey = "8AEkjWAMTQg20MKLY6GHqLO5y9pWm4rTVOugKs8FpQk=";
        }
        {
          allowedIPs = [ "10.10.10.4/32" ];
          publicKey = "6HRTAMMZi/+rw+niq8RX8KblxY0bYB3Cs9tKuaHqNg8=";
        }
        {
          allowedIPs = [ "10.10.10.2/32" ];
          publicKey =
            "CJAsUIfb2ifA0l9usxC+bGtx6CmFd2r98XQK86thMR0="; # thinkpad-x1
        }
      ];
    };

  };
}
