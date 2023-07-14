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

  users.groups.acme.members = [ "mosquitto" ];
}
