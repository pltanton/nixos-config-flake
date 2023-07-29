{ config, pkgs, ... }:

let domain = "grafana.kaliwe.ru";
in {
  services = {
    grafana = {
      enable = true;
      settings = {
        server = {
          domain = domain;
          root_url = "https://${domain}";
          http_port = 3001;
        };
      };
    };
  };

  services.caddy.virtualHosts."${domain}".extraConfig = ''
    reverse_proxy http://127.0.0.1:${
      toString config.services.grafana.settings.server.http_port
    }
  '';
}
