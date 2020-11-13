{ config, pkgs, secrets, ... }:

let
  valetudoMapper = {
    mqtt = {
      identifier = "rockrobo";
      topicPrefix = "valetudo";
      autoconfPrefix = "homeassistant";
      broker_url = "mqtt://hass:${secrets.mqtt_unpacked.hass}@172.17.0.1";
      caPath = "";
      mapDataTopic = "valetudo/rockrobo/map_data";
      minMillisecondsBetweenMapUpdates = 10000;
      publishMapImage = true;
      publishMapData = true;
    };
    mapSettings = {
      colors = {
        background = "#33a1f5";
        background2 = "#046cd4";
        floor = "#56affc";
        obstacle_strong = "#a1dbff";
        path = "white";
        forbidden_marker = "red";
        forbidden_zone = "rgba(255, 0, 0, 0.38)";
        cleaned_marker = "rgba(53, 125, 46, 1.0)";
        cleaned_zone = "rgba(107, 244, 66, 0.3)";
        cleaned_block = "rgba(107, 244, 36, 0.34)";
      };
      drawPath = true;
      drawCharger = true;
      drawRobot = true;
      drawCurrentlyCleanedZones = true;
      drawCurrentlyCleanedBlocks = false;
      drawForbiddenZones = true;
      drawVirtualWalls = true;
      scale = 4;
      gradientBackground = true;
      autoCrop = 20;
      #crop_x1= 30,
      #crop_y1= 70,
      #crop_x2= 440,
      #crop_y2= 440
    };
    webserver = {
      enabled = true;
      port = 3000;
    };
  };

  valetudoMapperConfig =
    builtins.toFile "valetudo-config.json" (builtins.toJSON valetudoMapper);
in {

  virtualisation.oci-containers.containers = {
    valetudo-mapper = {
      image = "rand256/valetudo-mapper";
      ports = [ "3001:3000" ];
      volumes = [
        "/etc/valetudo-config.json:/app/config.json"
      ];
    };
  };

  systemd.services.docker-valetudo-mapper = {
    serviceConfig.ExecStartPre = pkgs.lib.mkForce (pkgs.writeShellScript "valetudo-pre-start.sh" ''
      ${pkgs.docker}/bin/docker rm -f valetudo-mapper || true
      install -D ${valetudoMapperConfig} /etc/valetudo-config.json
    '');
  };

  services = {
    nginx = {
      virtualHosts."vacuum.kaliwe.ru" = {
        enableACME = true;
        forceSSL = true;
        basicAuth = { admin = secrets.homewikipass; };
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
    };
  };
}
