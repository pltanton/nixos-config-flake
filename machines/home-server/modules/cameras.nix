{ config, pkgs, secrets, ... }:

let
  consts = import ../constants.nix;
  storageDir = "${consts.storeMountPoint}/motioneye";

in {
  virtualisation.oci-containers.containers."motioneye" = {
    image = "ccrisan/motioneye:master-amd64";
    ports = [ "8765:8765" ];
    volumes = [
      "/etc/localtime:/etc/localtime:ro"

      "${storageDir}/config:/etc/motioneye"
      "${storageDir}/data:/var/lib/motioneye"
    ];
    extraOptions = [ "--network=host" ];
  };

  services = {
    nginx = {
      virtualHosts."motioneye.kaliwe.ru" = {
        enableACME = true;
        forceSSL = true;
        locations."/".proxyPass = "http://localhost:8765";

        basicAuth = {
          admin = secrets.homewikipass;
        };

        extraConfig = ''
          satisfy any;
          allow 192.168.0.0/16;
          deny all;
        '';
        };
    };
  };
}
