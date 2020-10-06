{ config, pkgs, ... }:
{
  system.stateVersion = "20.09";
  imports = builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules))
    ++ (builtins.map (name: ../../common-machines + "/${name}")
      (builtins.attrNames (builtins.readDir ../../common-machines)))
  ;

  systemd = {
    network.enable = true;
    enableEmergencyMode = false;
  };

  networking = {
    firewall = {
      allowedUDPPorts = [ 51820 2282 ];
      allowedTCPPorts = [ 53589 9090 1194 8080 8200 2282 3256 3000 443 80 ];
      extraCommands = ''
        iptables -t nat -A POSTROUTING -s10.10.10.0/24 -j MASQUERADE
      '';
    };
  };

  services.nginx.enable = true;
  services.atd.enable = true;

  virtualisation.docker.enable = true;
  security.acme.email = "plotnikovanton@gmail.com";
  security.acme.acceptTerms = true;

  nixpkgs.config.allowUnfree = true;

  users.extraUsers.proxyuser = {
    isSystemUser = true;
    description = "User for proxy athentication";
  };
}
