{ config, pkgs, ... }:

{
  networking.wireguard.interfaces = {
    wg0-kaliwe = let 
      host = "195.201.150.251";
      ip = "${pkgs.iproute}/bin/ip";
      rules = action: [
        "${ip} rule ${action} to 192.168.0.0/16 lookup main pref 30" # Home assistant
        "${ip} rule ${action} to ${host} lookup main pref 30"
        "${ip} rule ${action} to all lookup 80 pref 40"
        "${ip} route ${action} default dev wg0-kaliwe table 80"
      ];

    in {
      ips = [ "10.10.10.2/32" ];
      privateKeyFile = "/root/nixos/wg/kaliwe";
      allowedIPsAsRoutes = false;
      postSetup = rules "add"; 
      postShutdown = rules "del";

      peers = [
        {
          publicKey = "0vuNrDaID3o8YwbNBZ7RViB0O0z6Kt32mpK36PUDgg8=";
          allowedIPs = [ "0.0.0.0/0" ];
          endpoint = "${host}:51820";
          persistentKeepalive = 25;
        }
      ];
    };
  };
}

