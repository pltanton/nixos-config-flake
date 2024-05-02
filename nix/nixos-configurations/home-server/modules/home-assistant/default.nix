{
  config,
  pkgs,
  ...
}: {
  imports = [./home-assistant.nix ./mosquitto.nix ./zigbee2mqtt.nix];
}
