{ config, pkgs, ... }:

{
  imports = builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  boot.loader.systemd-boot.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  systemd = {
    network.enable = true;
    enableEmergencyMode = false;
  };

  time.timeZone = "Europe/Moscow";

  networking = {
    hostName = "home-server";
    #useDHCP = true;
    #resolvconf.useLocalResolver = true;
    networkmanager.enable = false;

    firewall.enable = false;
    firewall.allowedTCPPorts = [
      22
      80
      443
      8096

      1883 # Mosquitto
      8883 # Mosquitto ssl
      8123 # Home-assistant

      5901 # VNC
    ];
  };

  environment.systemPackages = with pkgs; [ vim tmux git ];

  users = {
    users = {
      publicstore = {
        isSystemUser = true;
        shell = pkgs.bashInteractive;
        uid = 1040;
      };
      privatestore = {
        isSystemUser = true;
        shell = pkgs.bashInteractive;
        uid = 1050;
      };
      nginx = { extraGroups = [ "mosquitto" ]; };
    };

    groups = {
      publicstore = { gid = 1040; };
      privatestore = { gid = 1050; };
    };
  };

  nixpkgs.config.allowUnfree = true;
  security.acme.acceptTerms = true;
}
