{ pkgs, ... }: {
  networking = {
    #nameservers = [ "8.8.8.8" ];
    hosts = { };
    networkmanager.enable = true;

    firewall.allowedUDPPorts = [ 8080 ];
    firewall.allowedTCPPorts = [ 8080 ];
  };
}
