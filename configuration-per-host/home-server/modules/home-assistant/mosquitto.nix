{ config, pkgs, secrets, ... }: {
  services.mosquitto = {
    enable = true;
    listeners = [{
      settings = {

      };
      users = {
        hass = {
          acl = [ "readwrite #" ];
          password = secrets.mqtt_unpacked.hass;
        };
      };
    }];
  };

  services.nginx.virtualHosts."mqtt.kaliwe.ru" = { enableACME = true; };

  users.groups.acme.members = [ "mosquitto" ];
}
