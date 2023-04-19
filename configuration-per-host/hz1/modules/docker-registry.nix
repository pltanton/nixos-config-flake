{ pkgs, ... }:

{
  # networking.firewall.allowedTCPPorts = [ 5000 ];
  # services.dockerRegistry = {
  #   enable = true;
  #   enableGarbageCollect = true;
  #   enableDelete = true;
  #   listenAddress = "127.0.0.1";
  #   port = 5000;
  #   extraConfig = {
  #     auth = {
  #       htpasswd = {
  #         realm = "default";
  #         path = "/var/lib/docker-registry/auth";
  #       };
  #     };
  #   };
  # };

  # services.nginx = {
  #   enable = true;
  #   virtualHosts."registry.kaliwe.ru" = {
  #     enableACME = true;
  #     forceSSL = true;
  #     locations."/".proxyPass = "http://127.0.0.1:5000";
  #   };
  # };

  # security.acme.certs = {
  #   "registry.kaliwe.ru".email = "plotnikovanton@gmail.com";
  # };
}
