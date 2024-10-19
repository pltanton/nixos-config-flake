{
  config,
  pkgs,
  ...
}: {
  imports =
    builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  boot.loader.systemd-boot.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  systemd = {
    network = {
      enable = true;
      networks = {
        "10-enp1s0" = {
          matchConfig.Name = "enp1s0";
          networkConfig = {
            DHCP = "ipv4";
            IPv6AcceptRA = "no";
            LinkLocalAddressing = "no";
          };
        };
      };
      wait-online.anyInterface = true;
      wait-online.timeout = 10;
      wait-online.ignoredInterfaces = ["wg0" "wg-hz"];
    };
    enableEmergencyMode = false;
  };

  time.timeZone = "Europe/Moscow";

  sops.secrets."networking-environment" = {};

  networking = {
    hostName = "home-server";
    useNetworkd = true;
    # useDHCP = true;
    #resolvconf.useLocalResolver = true;
    networkmanager.enable = false;
    nameservers = ["1.1.1.1" "8.8.8.8"];

    wireless = {
      enable = true;
      userControlled.enable = true;
      secretsFile = config.sops.secrets."networking-environment".path;
      networks."Ananasik" = {psk = "ext:ananasik";};
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
    };

    groups = {
      publicstore = {gid = 1040;};
      privatestore = {gid = 1050;};
    };
  };

  nixpkgs.config.allowUnfree = true;
  security.acme.acceptTerms = true;

  nixpkgs.config.permittedInsecurePackages = ["openssl-1.1.1w"];
}
