{
  config,
  pkgs,
  lib,
  sops,
  ...
}: let
  ip = "${pkgs.iproute2}/bin/ip";
  rules = action: host: iface: [
    "${ip} rule ${action} to 192.168.0.0/16 lookup main pref 30" # Home assistant
    "${ip} rule ${action} to 10.100.0.0/24 lookup main pref 30" # Home server wireguard
    "${ip} rule ${action} to ${host} lookup main pref 30"
    "${ip} rule ${action} to all lookup 80 pref 40"
    "${ip} route ${action} default dev ${iface} table 80"
  ];
in {
  # systemd.services.wireguard-wg-home = {
  #   before = lib.mkForce [ ];
  #   after = lib.mkForce [ ];
  # };
  # systemd.services.wireguard-wg-hz1 = {
  #   before = lib.mkForce [ ];
  #   after = lib.mkForce [ ];
  # };
  # systemd.services.wireguard-wg-sprintbox = {
  #   before = lib.mkForce [ ];
  #   after = lib.mkForce [ ];
  # };

  sops.secrets."wireguard/gen9/home" = {};
  sops.secrets."wireguard/gen9/hz1" = {};

  networking.wireguard.interfaces = {
    wg-home = {
      privateKeyFile = "/run/secrets/wireguard/gen9/home";
      ips = ["10.100.0.4/32"];
      peers = [
        {
          publicKey = "Rv9ZSp8/fvFj1Zohwragvv4K4Z+qo0c9rinZvfaJ5CY=";
          allowedIPs = ["10.100.0.0/24"];
          # endpoint = "home.kaliwe.ru:51820";
          endpoint = "192.168.0.100:51820";
          persistentKeepalive = 25;
        }
      ];
    };

    wg-hz1 = {
      ips = ["10.10.10.2/32"];
      privateKeyFile = "/run/secrets/wireguard/gen9/hz1";
      peers = [
        {
          allowedIPs = ["10.10.10.0/24"];
          publicKey = "0vuNrDaID3o8YwbNBZ7RViB0O0z6Kt32mpK36PUDgg8=";
          endpoint = "195.201.150.251:51820";
          persistentKeepalive = 25;
        }
      ];
    };

    # wg-sprintbox = {
    #   privateKey = secrets.wg.sprintbox.privateKey;
    #   ips = [ "10.10.10.2/32" ];

    #   peers = [{
    #     allowedIPs = [ "0.0.0.0/0" ];
    #     publicKey = "Yu5mgRISx/lZO0bBsBXeXi2jgzcJLupjEDPBCzgZFFo=";
    #     endpoint = "141.8.195.83:51820";
    #     persistentKeepalive = 25;
    #   }];
    # };

    #   wg-hz1 = let host = "195.201.150.251";
    #   in {
    #     ips = [ "10.10.10.2/32" ];
    #     privateKey = secrets.wg.hz1.privateKey;
    #     allowedIPsAsRoutes = false;
    #     postSetup = rules "add" host "wg-hz1";
    #     postShutdown = rules "del" host "wg-hz1";

    #     peers = [{
    #       allowedIPs = [ "0.0.0.0/0" ];
    #       publicKey = "0vuNrDaID3o8YwbNBZ7RViB0O0z6Kt32mpK36PUDgg8=";
    #       endpoint = "${host}:51820";
    #       persistentKeepalive = 25;
    #     }];
    #   };
  };
}
