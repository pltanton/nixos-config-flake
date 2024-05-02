{pkgs, ...}: {
  networking = {firewall = {allowedTCPPorts = [443 80];};};
  services.caddy.enable = true;
  services.nginx.enable = false;
}
