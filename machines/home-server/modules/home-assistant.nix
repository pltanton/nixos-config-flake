{ config, pkgs, ... }:

let
  consts = import ../constants.nix;
  secrets = import ../secrets.nix;

  mqttUrl = "mqtt.kaliwe.ru";
in {
  # Generally home-assistant installation is a bunch of applications:
  #   1. The home-assistant in docker container, because nix-based container
  #      is really hard to maintain and it lack of usefull python packages that i need.
  #   2. MQTT server - mosquitto as nix-service.
  #   3. Zigbee2mqtt as docker conatienr. It could be replaced with nix-service in future.
  #   4. ??? OwnTracks ???
  #   5. Ofcourse nginx modules to rule them all
  virtualisation.oci-containers.containers = {
    # HASS container itself
    home-assistant = {
      image = "homeassistant/home-assistant:latest";
      ports = [ "8123:8123" ];
      environment = { TZ = consts.TZ; };
      extraOptions = [ "--network=host" ];
      volumes = [ "/var/lib/hass:/config" ];
    };

    # zigbee2mqtt container
    zigbee2mqtt = {
      image = "koenkk/zigbee2mqtt";
      ports = [ "8123:8123" ];
      environment = { TZ = consts.TZ; };
      extraOptions = [
        "--device=/dev/ttyACM0"
        "--network=host"
        "--privileged=true" # required to get acces to /dev/tty*
      ];
      volumes = [ "/var/lib/zigbee2mqtt:/app/data" ];
    };

    valetudo-mapper = let
    in {
      image = "rand256/valetudo-mapper";
      ports = [ "3001:3000" ];
      #volumes = [ "${config}:/app/config.json" ];
      volumes = [ "${secrets.files.valetudo-config.destination}:/app/config.json" ];
    };
  };

  # NIX based pure services
  services = {
    mosquitto = {
      enable = true;
      host = "0.0.0.0";
      ssl = {
        enable = true;
        certfile = "/var/lib/acme/${mqttUrl}/cert.pem";
        cafile = "/var/lib/acme/${mqttUrl}/chain.pem";
        keyfile = "/var/lib/acme/${mqttUrl}/key.pem";
      };
      users = {
        hass = {
          acl = [ "topic readwrite #" ];
          hashedPassword = secrets.mqtt.hass;
        };
        anton = {
          acl = [ "topic readwrite #" ];
          hashedPassword = secrets.mqtt.anton;
        };
      };
    };

    nginx = {
      virtualHosts."${mqttUrl}" = {
        enableACME = true;
        forceSSL = true;
      };

      virtualHosts."vacuum.kaliwe.ru" = {
        enableACME = true;
        forceSSL = true;
        basicAuthFile = secrets.files.homewiki.destination;
        extraConfig = ''
          satisfy any;
          allow 192.168.0.0/16;
          deny all;
        '';

        locations."/" = {
          proxyPass = "http://10.1.0.207:80";
          proxyWebsockets = true;
        };
      };

      virtualHosts."hass.kaliwe.ru" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8123";
          proxyWebsockets = true;

          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
          '';
        };
      };
    };
  };

  security.acme.certs."${mqttUrl}" = {
    group = "mosquitto";
  };
}
