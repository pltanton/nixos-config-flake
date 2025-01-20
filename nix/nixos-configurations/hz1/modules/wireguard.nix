{
  pkgs,
  sops,
  ...
}: {
  networking = {
    nat = {
      enable = true;
      internalInterfaces = ["wg0"];
      externalInterface = "ens3";
    };

    firewall = {allowedUDPPorts = [51820];};
  };

  sops.secrets."wireguard/hz1" = {};

  networking.wireguard.interfaces = {
    wg0 = {
      ips = ["10.10.10.1/24"];
      listenPort = 51820;
      privateKeyFile = "/run/secrets/wireguard/hz1";

      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o ens3 -j MASQUERADE
      '';

      # This undoes the above command
      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o ens3 -j MASQUERADE
      '';

      peers = [
        {
          allowedIPs = ["10.10.10.10/32"]; # Home server
          publicKey = "8AEkjWAMTQg20MKLY6GHqLO5y9pWm4rTVOugKs8FpQk=";
        }
        {
          allowedIPs = ["10.10.10.4/32"];
          publicKey = "6HRTAMMZi/+rw+niq8RX8KblxY0bYB3Cs9tKuaHqNg8=";
        }
        {
          allowedIPs = ["10.10.10.2/32"];
          publicKey = "CJAsUIfb2ifA0l9usxC+bGtx6CmFd2r98XQK86thMR0="; # thinkpad-x1
        }
      ];
    };
  };
}
