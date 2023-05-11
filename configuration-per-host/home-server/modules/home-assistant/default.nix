{ config, pkgs, ... }:

{
  imports =
    [ ./valetudo.nix ./home-assistant.nix ./mosquitto.nix ./zigbee2mqtt.nix ];
}
