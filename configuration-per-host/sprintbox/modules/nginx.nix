{ pkgs, ... }: {
  networking = { firewall = { allowedTCPPorts = [ 443 80 ]; }; };
  services.nginx.enable = true;
  services.nginx.recommendedProxySettings = true;
}
