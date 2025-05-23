{config, ...}: {
  sops.secrets = {
    "wireguard/hz1" = {};
    "wireguard/home" = {};
  };

  networking = {
    nat = {
      enable = true;
      internalInterfaces = ["wg-home" "wg-hz"];
    };
    firewall = {allowedUDPPorts = [51820];};

    wireguard.interfaces = {
      wg-home = {
        ips = ["10.100.0.1/24"];
        listenPort = 51820;

        privateKeyFile = config.sops.secrets."wireguard/home".path;

        peers = [
          {
            allowedIPs = ["10.100.0.2/32"];
            publicKey = "+Sn1TvwU92p1ZiGQfv0qSCbSML894x/u7OuLRH0URig=";
          }
          {
            allowedIPs = ["10.100.0.3/32"];
            publicKey = "TZeNcgaKDcQRsUktBPcjtcKbVLouDkc24jdoSrWHtVs="; # Thinkpad x1
          }
          {
            allowedIPs = ["10.100.0.4/32"];
            publicKey = "TB6b0XRczhJmH/yyVIL0gCPGL4sIx3EcMti28og0g14="; # Thinkpad x1 gen9
          }
        ];
      };

      wg-hz = {
        privateKeyFile = config.sops.secrets."wireguard/hz1".path;
        ips = ["10.10.10.10/32"];
        peers = [
          {
            publicKey = "0vuNrDaID3o8YwbNBZ7RViB0O0z6Kt32mpK36PUDgg8=";
            allowedIPs = ["10.10.10.0/24"];
            endpoint = "hz1.kaliwe.ru:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
