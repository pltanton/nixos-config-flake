{ config, pkgs, ... }: {
  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = { allowedUDPPorts = [ 51820 ]; };

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.1/24" ];
      listenPort = 51820;

      privateKeyFile = "/root/nixos/wgkey";

      peers = [
        {
        allowedIPs = [ "10.100.0.2/32" ];
        publicKey = "+Sn1TvwU92p1ZiGQfv0qSCbSML894x/u7OuLRH0URig=";
        }
        {
        allowedIPs = [ "10.100.0.3/32" ];
        publicKey = "s0FRSfH6u9aGupCIc3CHgwk4rv26+z6yKX165E3W+WA=";
        }
      ];
    };
  };

}
