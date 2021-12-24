{ pkgs, ... }: {
  networking = {
    nameservers = [ "10.100.0.1" ];
    hosts = { };
    networkmanager.enable = true;
    resolvconf.extraOptions = [ "rotate" "timeout:1" ];
    search = [ "thinkpad-x1.home" ];

    firewall.allowedUDPPorts = [ 8080 ];
    firewall.allowedTCPPorts = [ 8080 ];
  };
}
