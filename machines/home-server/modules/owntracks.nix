{ config, pkgs, ... }:

let
  secrets = import ../secrets.nix;
  consts = import ../constants.nix;
  frontend-config = builtins.toFile "owntracks-frontend-config.js" ''
    window.owntracks = window.owntracks || {};
    window.owntracks.config = {};
  '';
in {
  virtualisation.oci-containers.containers = {
    owntracks-recorder = {
      image = "owntracks/recorder";
      ports = [ "8083:8083" ];
      environment = {
        OTR_HOST = "localhost";
        OTR_PORT = "1883";
        OTR_USER = "hass";
        OTR_PASS = secrets.mqtt_unpacked.hass;
      };
      volumes = [ "${consts.mediaAppHomes}/owntracks-recorder-home:/store" ];
      extraOptions = [ "--network=host" ];
    };

    owntracks-frontend = {
      image = "owntracks/frontend";
      ports = [ "8085:8085" ];
      environment = {
        SERVER_HOST = "localhost";
        SERVER_PORT = "8083";
        LISTEN_PORT = "8085";
      };
      volumes = [
        "${frontend-config}:/usr/share/nginx/html/config/config.js"
      ];
      extraOptions = [ "--network=host" ];
    };
  };

  services = {
    nginx = {
      virtualHosts."owntracks.kaliwe.ru" = {
        enableACME = true;
        forceSSL = true;
        locations."/".proxyPass = "http://localhost:8085";
        basicAuth = {
          admin = secrets.owntracksPassword;
        };
      };
    };
  };

}
