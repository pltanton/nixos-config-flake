{ config, pkgs, secrets, ... }:

let
  consts = import ../../constants.nix;

  mqttUrl = "mqtt.kaliwe.ru";
in {
  imports = [ ./valetudo.nix ];
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
      image = "homeassistant/home-assistant:stable";
      ports = [ "8123:8123" ];
      environment = { TZ = consts.TZ; };
      extraOptions = [ "--network=host" ];
      volumes = [ "/var/lib/hass:/config" ];
    };
  };

  # NIX based pure services
  services = {
    zigbee2mqtt = {
      enable = true;
      settings = {
        homeassistant = true;
        permit_join = true;
        serial = { port = "/dev/ttyACM0"; };
        mqtt = {
          base_topic = "zigbee2mqtt";
          server = "http://localhost";
          user = "hass";
          password = secrets.mqtt_unpacked.hass;
        };
        devices = {
          "0x00158d000301606a" = { friendly_name = "corridor_light_relay"; };
          "0x00158d000302ef25" = { friendly_name = "bathroom_light_relay"; };
          "0x00158d00014a5529" = { friendly_name = "room_light_relay"; };
          "0x00124b001f9b061f" = { friendly_name = "bed_wireless_button"; };
          "0x00158d00014a9c3c" = { friendly_name = "kitchen_light_relay"; };
          "0x00124b002236c654" = { friendly_name = "kitchen_proxy_switch"; };
          "0x00124b001f877829" = { friendly_name = "balcony_climate_sensor"; };
          "0x00124b002236ebf7" = { friendly_name = "balcony_light_switch"; };
        };
      };
    };

    mosquitto = {
      enable = true;
      host = "0.0.0.0";
      checkPasswords = true;
      ssl = {
        enable = true;
        certfile = "/var/lib/acme/${mqttUrl}/cert.pem";
        cafile = "/var/lib/acme/${mqttUrl}/chain.pem";
        keyfile = "/var/lib/acme/${mqttUrl}/key.pem";
      };
      users = {
        hass = {
          acl = [ "topic readwrite #" ];
          password = "jHSMoBqZeHquJkYWFty05LcWi";
          # hashedPassword =
          # "$6$UnJaE3YIuwd+A2Ns$iXISY1S8PueeraD6bWpj8H/bfKTnmR+4uDb+jSboMp87zNUPc9l1shruAn3VQe+wpcdEE1beYbOdvj5k6mxVgQ==";
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

  security.acme.certs."${mqttUrl}" = { group = "mosquitto"; };
}
