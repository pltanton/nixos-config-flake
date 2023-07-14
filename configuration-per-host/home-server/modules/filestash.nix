{ config, pkgs, ... }:

let
  consts = import ../constants.nix;
  publicPort = "8334";
in {
  # virtualisation.oci-containers.containers."felstash" = {
  #   image = "machines/filestash";
  #   ports = [ "${publicPort}:8334" ];
  #   extraOptions = [ "--network=host" ];
  #   volumes = [ "${consts.mediaAppHomes}/filestash-home:/app/data/state" ];
  # };

  # services.caddy.virtualHosts."filestash.kaliwe.ru".extraConfig = ''
  #   reverse_proxy http://127.0.0.1:${publicPort}
  # '';
}
