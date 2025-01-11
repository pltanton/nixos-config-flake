{config, ...}: {
  sops.secrets."mosquitto/hass" = {};
  services.mosquitto = {
    enable = true;
    listeners = [
      {
        settings = {
        };
        users = {
          hass = {
            acl = ["readwrite #"];
            passwordFile = config.sops.secrets."mosquitto/hass".path;
          };
        };
      }
    ];
  };

  users.groups.acme.members = ["mosquitto"];
}
