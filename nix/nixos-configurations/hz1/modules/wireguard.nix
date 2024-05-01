{ config, pkgs, sops, ... }:

{
  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.nat.externalInterface = "ens3";
  networking.firewall = { allowedUDPPorts = [ 51820 ]; };

  sops.secrets."wireguard/hz1" = {};

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.10.10.1/24" ];
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
        #
        # Shared mobile clients
        #
        {
          allowedIPs = [ "10.10.10.201/32" ]; # anton phone
          publicKey = "X+hnsZvI22mPPdQ2f3W6XZwBXfoblDcJGtJtSj0x4lU=";
        }
        {
          allowedIPs = [ "10.10.10.202/32" ]; # slava phone
          publicKey = "f8ogEhKiJ9QoLcn0yIXayh9nlsAQSFvm9H+gAq6wPFg=";
        }
        {
          allowedIPs = [ "10.10.10.203/32" ]; # slava pc
          publicKey = "SalQn0TxkJtK2CTIhTjbfYN/b1XaOjOb+TTLegZFvRg=";
        }
        {
          allowedIPs = [ "10.10.10.204/32" ]; # julsa phone
          publicKey = "1438i5+NSf/+7V5T1NpT+cU3XfCLgTiydpb/TW46vnQ=";
        }
        {
          allowedIPs = [ "10.10.10.205/32" ]; # julsa pc
          publicKey = "nQUPd8lfyOtkuwOBLkv/DF6937QGYWBIE8YrnNSEr0E=";
        }
        {
          allowedIPs = [ "10.10.10.206/32" ]; # ilya phone
          publicKey = "MB2qObDD68J+vfcj6hyf7gCoZcbA9anqh7W2A2wo8F8=";
        }
        {
          allowedIPs = [ "10.10.10.207/32" ]; # ilya pc
          publicKey = "DOGViCn15QPd3kBPHZpIPy8DS574iEY0MVM0Aa0G9QY=";
        }
        {
          allowedIPs = [ "10.10.10.208/32" ]; # slava tablet
          publicKey = "dPdeMPwUBUsOUGgvMwtVd+fza6vK30ntto6l2oHU0AU=";
        }
        {
          allowedIPs = [ "10.10.10.209/32" ]; # slava mac
          publicKey = "CxJgnutIiQpjYGGLDQZtD/b07cePINrjbaKJF5AbT1Q=";
        }
        {
          allowedIPs = [ "10.10.10.210/32" ]; # papa 1
          publicKey = "mC/nrtTgfOZ44YTHCJMyN0zB40JlK96ONGRPKO62zmQ=";
        }
        {
          allowedIPs = [ "10.10.10.211/32" ]; # pavel b 1
          publicKey = "JB4d5wDPbr72um0g6TP9t0N9uRvT9pdFpeJ7Hqj+k3M=";
        }
      ];
    };
  };
}
