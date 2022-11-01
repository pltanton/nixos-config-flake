{ config, pkgs, secrets, ... }:

{
  networking.firewall.enable = false;
  networking.firewall = { allowedUDPPorts = [ 51820 ]; };
  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "wg-sprintbox" ];
  networking.nat.externalInterface = "ens3";

  networking.wireguard.interfaces = {
    wg-sprintbox = {
      ips = [ "10.10.10.1/24" ];
      listenPort = 51820;
      privateKey = secrets.wireguard.server;
      peers = [
        {
          allowedIPs = [ "10.10.10.2/32" ];
          publicKey = "W1a3Fdij/Sk/GDMOl37msCzVjJHcKM2qcdp2dgliVSI=";
        }
        {
          allowedIPs = [ "10.10.10.201/32" ];
          publicKey = "RGG0VTALtT0FfYFpuAoPBj8mspaD1YfZP51xbIWhFXE=";
        }
      ];

      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s10.10.10.0/24 -o ens3 -j MASQUERADE
      '';

      # This undoes the above command
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s10.10.10.0/24 -o ens3 -j MASQUERADE
      '';
    };
  };
}
