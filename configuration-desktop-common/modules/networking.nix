{ pkgs, ... }: {
  networking = {
    nameservers = [ "10.100.0.1" ];
    hosts = { };
    networkmanager.enable = true;

    firewall.allowedUDPPorts = [ 8080 ];
    firewall.allowedTCPPorts = [ 8080 ];
  };
}
