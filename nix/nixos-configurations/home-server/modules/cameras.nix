{ config, pkgs, secrets, ... }:

let
  consts = import ../constants.nix;
  storageDir = "${consts.storeMountPoint}/motioneye";

in {
  virtualisation.oci-containers.containers."motioneye" = {
    image = "ccrisan/motioneye:dev-amd64";
    ports = [ "8765:8765" ];
    volumes = [
      "/etc/localtime:/etc/localtime:ro"

      "${storageDir}/config:/etc/motioneye"
      "${storageDir}/data:/var/lib/motioneye"
    ];
    extraOptions = [ "--network=host" ];
  };

  networking.firewall.allowedTCPPorts = [ 8081 8082 ];

  services.caddy.virtualHosts."motioneye.kaliwe.ru".extraConfig = ''
    reverse_proxy http://127.0.0.1:8765
  '';
}
