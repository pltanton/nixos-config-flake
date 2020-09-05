{ pkgs, ... }: {
  networking = {
    #nameservers = [ "8.8.8.8" ];
    hostName = "nixos";
    hosts = { };
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 22 8888 ];
    firewall.enable = false;
  };
}
