{config, ...}: let
  domain = "grafana.kaliwe.ru";
in {
  services = {
    grafana = {
      enable = true;
      settings = {
        unified_alerting = {
          enabled = "true";
        };

        "unified_alerting.screenshot" = {
          capture = "true";
        };

        server = {
          inherit domain;
          root_url = "https://${domain}";
          http_port = 3001;
        };
      };
    };

    grafana-image-renderer = {
      enable = false;
      provisionGrafana = false;
    };
  };

  services.caddy.virtualHosts."${domain}".extraConfig = ''
    reverse_proxy http://127.0.0.1:${
      toString config.services.grafana.settings.server.http_port
    }
  '';
}
