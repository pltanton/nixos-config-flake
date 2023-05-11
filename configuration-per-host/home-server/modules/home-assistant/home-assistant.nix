{ config, pkgs, ... }: {
  services.home-assistant = {
    enable = false;
    extraComponents = [
      # Components required to complete the onboarding
      "met"
      "radio_browser"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = { };

      http = {
        server_host = "::1";
        trusted_proxies = [ "::1" ];
        use_x_forwarded_for = true;
      };

      # recorder.db_url = "postgresql://@/hass";
    };
    package =
      (pkgs.home-assistant.override { extraPackages = ps: [ ps.psycopg2 ]; });

    # extraPackages = python3Packages:
    #   with python3Packages;
    #   [
    #     # postgresql support
    #     psycopg2
    #   ];
  };

  services.nginx = {
    virtualHosts."hass.kaliwe.ru" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:8123";
        proxyWebsockets = true;

        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
        '';
      };
    };
  };
}
