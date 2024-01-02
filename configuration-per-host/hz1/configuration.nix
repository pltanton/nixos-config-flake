{ config, pkgs, inputs, ... }: {
  system.stateVersion = "20.09";
  imports = builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  systemd = {
    network = {
      enable = false;
      wait-online.anyInterface = true;
      wait-online.timeout = 10;
      wait-online.ignoredInterfaces = [ "wg0" ];
    };

    enableEmergencyMode = false;
    # targets.systemd-networkd-wait-online.wantedBy =
    #   pkgs.lib.mkForce [ ]; # Normally ["multi-user.target"]
    # targets.network-online.wantedBy =
    #   pkgs.lib.mkForce [ ]; # Normally ["multi-user.target"]
    # services.NetworkManager-wait-online.wantedBy =
    #   pkgs.lib.mkForce [ ]; # Normally ["network-online.target"]

  };

  environment.systemPackages = [ pkgs.vim ];
  networking = {
    useDHCP = true;
    useNetworkd = false;

    hostName = "hz1";

    # defaultGateway.interface = "ens3";

    networkmanager.enable = false;
    firewall = {
      allowedUDPPorts = [ 51820 2282 ];
      allowedTCPPorts =
        [ 53589 9090 1194 8080 8200 2282 3256 3000 443 80 3030 6878 ];
    };
  };

  services.atd.enable = true;

  virtualisation.docker.enable = true;
  security.acme.defaults.email = "plotnikovanton@gmail.com";
  security.acme.acceptTerms = true;

  nixpkgs.config.allowUnfree = true;

  users.groups.proxyuser = {};
  users.extraUsers.proxyuser = {
    group = "proxyuser";
    isSystemUser = true;
    description = "User for proxy athentication";
  };

  # SOPS configuration
  sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
  sops.defaultSopsFile = ./secrets.yaml;
  sops.age.generateKey = true;
}
