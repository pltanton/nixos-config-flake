{config, ...}: {
  sops.secrets."mosquitto/hass" = {};
  sops.secrets."mosquitto/frigate" = {};
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
          frigate = {
            acl = ["readwrite #"];
            passwordFile = config.sops.secrets."mosquitto/frigate".path;
          };
        };
      }
    ];
  };

  users.groups.acme.members = ["mosquitto"];
}
