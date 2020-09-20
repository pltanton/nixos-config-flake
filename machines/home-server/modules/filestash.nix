{ config, pkgs, ... }:

let
  consts = import ../constants.nix;
  publicPort = "8334";
in {

  services = {
    nginx = {
      virtualHosts."filestash.kaliwe.ru" = {
        extraConfig = ''
          proxy_http_version 1.1;
          proxy_set_header Upgrade $http_upgrade;
          proxy_set_header Connection "upgrade";

          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_set_header Origin "";
        '';
        enableACME = true;
        forceSSL = true;
        locations."/".proxyPass = "http://localhost:${publicPort}";
      };
    };
  };

  users.users.airsonic.extraGroups = [ "publicstore" ];

  virtualisation.oci-containers.containers."felstash" = {
    image = "machines/filestash";
    ports = [ "${publicPort}:8334" ];
    extraOptions = [ "--network=host" ];
    volumes = [ "${consts.mediaAppHomes}/filestash-home:/app/data/state" ];
  };
}
