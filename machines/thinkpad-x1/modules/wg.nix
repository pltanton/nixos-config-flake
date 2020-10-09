{ config, pkgs, ... }:

{
  networking.wireguard.interfaces = {
    # wg0-home = {
    #   privateKeyFile = "/root/nixos/wg/home";
    #   ips = [ "10.100.0.3/32" ];
    #   peers = [
    #     {
    #       publicKey = "Rv9ZSp8/fvFj1Zohwragvv4K4Z+qo0c9rinZvfaJ5CY=";
    #       allowedIPs = [ "10.100.0.0/24" ];
    #       endpoint = "home.kaliwe.ru:51820";
    #       persistentKeepalive = 25;
    #     }
    #   ];
    # };

#  wg0-kaliwe = let
#    host = "195.201.150.251";
#    ip = "${pkgs.iproute}/bin/ip";
#    rules = action: [
#      "${ip} rule ${action} to 192.168.0.0/16 lookup main pref 30" # Home assistant
#      "${ip} rule ${action} to 100.10.0.0/24 lookup main pref 30" # Home server wireguard
#      "${ip} rule ${action} to ${host} lookup main pref 30"
#      "${ip} rule ${action} to all lookup 80 pref 40"
#      "${ip} route ${action} default dev wg0-kaliwe table 80"
#    ];
#
#  in {
#    ips = [ "10.10.10.2/32" ];
#    privateKeyFile = "/root/nixos/wg/kaliwe";
#    allowedIPsAsRoutes = false;
#    postSetup = rules "add";
#    postShutdown = rules "del";
#
#    peers = [
#      {
#        publicKey = "0vuNrDaID3o8YwbNBZ7RViB0O0z6Kt32mpK36PUDgg8=";
#        allowedIPs = [ "0.0.0.0/0" ];
#        endpoint = "${host}:51820";
#        persistentKeepalive = 25;
#      }
#    ];
#  };

  };
}
