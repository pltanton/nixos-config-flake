{config, ...}: {
  sops.secrets."wireguard/hz1" = {};

  networking = {
    firewall = {
      allowedUDPPorts = [51820];
    };
    nat = {
      enable = true;
      internalInterfaces = ["wg-sprintbox" "wg-hz"];
      externalInterface = "ens3";
    };

    wireguard.interfaces = {
      wg-hz = {
        privateKeyFile = config.sops.secrets."wireguard/hz1".path;
        ips = ["10.10.10.11/32"];
        peers = [
          {
            publicKey = "FXjJtcUE2Y9TnGcLe+ojTTX7Dev2jUN21YephEoklEQ=";
            allowedIPs = ["10.10.10.0/24"];
            endpoint = "hz1.kaliwe.ru:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
