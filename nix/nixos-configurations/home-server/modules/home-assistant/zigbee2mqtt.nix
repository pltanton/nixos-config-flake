{config, ...}: {
  sops.secrets.zigbee2mqtt-secret = {
    path = "/var/lib/zigbee2mqtt/secrets.yaml";
    owner = "zigbee2mqtt";
  };
  services = {
    zigbee2mqtt = {
      enable = true;
      settings = {
        homeassistant = true;
        permit_join = false;
        serial = {port = "/dev/ttyUSB0";};
        advanced = {rtscts = false;};
        availability = true;
        mqtt = {
          base_topic = "zigbee2mqtt";
          server = "mqtt://localhost";
          user = "!${config.sops.secrets.zigbee2mqtt-secret.path} user";
          password = "!${config.sops.secrets.zigbee2mqtt-secret.path} password";
        };
        devices = {
          "0x00124b001f877829" = {friendly_name = "sonoff_climate_sensor_1";};
          "0x00124b002a4f0280" = {friendly_name = "sonoff_climate_sensor_2";};
          "0x00124b002a4f1b89" = {friendly_name = "sonoff_climate_sensor_3";};
          "0x00124b002a6bbee9" = {friendly_name = "sonoff_climate_sensor_4";};
          # "0x00158d000301606a" = { friendly_name = "corridor_light_relay"; };
          # "0x00158d000302ef25" = { friendly_name = "bathroom_light_relay"; };
          # "0x00158d00014a5529" = { friendly_name = "room_light_relay"; };
          # "0x00158d00014a9c3c" = { friendly_name = "kitchen_light_relay"; };
          # "0x00124b002236c654" = { friendly_name = "kitchen_proxy_switch"; };
          # "0x00124b002236ebf7" = { friendly_name = "balcony_light_switch"; };
          # "0x9035eafffea4e4a2" = { friendly_name = "room_air_quality_sensor"; };
          # "0x00124b001f9b061f" = { friendly_name = "sonoff_wireless_button"; };
        };
      };
    };
  };
}
