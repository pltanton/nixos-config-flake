{ config, pkgs, ... }:

let
  domain = "grafana.kaliwe.ru";
  port = 3001;
in {
  services = {
    grafana = {
      enable = true;
	  domain = domain;
	  rootUrl = "https://${domain}";
      port = port;
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts."${domain}" = {
      enableACME = true;
      forceSSL = true;

      locations."/".proxyPass = "http://127.0.0.1:${toString port}";
    };
  };

  security.acme.certs = {
    "${domain}".email = "plotnikovanton@gmail.com";
  };
}
