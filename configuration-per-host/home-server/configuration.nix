{ config, pkgs, secrets, ... }:

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

    wireless = {
      enable = true;
      userControlled.enable = true;
      networks."Ananasik" = { psk = secrets.wifiPassword; };
      networks."AnanasikRE" = {
        psk = secrets.wifiPassword;
        priority = 1;
      };
    };

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

  environment.systemPackages = with pkgs; [
    vim
    tmux
    git
    htop
    ffmpeg
    ranger
    btop
    duf
  ];

  users = {
    users = {
      publicstore = {
        group = "publicstore";
        isSystemUser = true;
        shell = pkgs.bashInteractive;
        uid = 1040;
      };
      privatestore = {
        group = "privatestore";
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

  system.stateVersion = "21.11";
}
