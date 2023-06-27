{ config, pkgs, ... }: {
  services.home-assistant = {
    enable = true;
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
    package = (pkgs.home-assistant.override {
      extraPackages = ps:
        with ps; [
          psycopg2
          paho-mqtt
          getmac
          huawei-lte-api
          url-normalize
        ];
    });

    # extraPackages = python3Packages:
    #   with python3Packages;
    #   [
    #     # postgresql support
    #     psycopg2
    #   ];
  };

  services.nginx = {
    recommendedProxySettings = true;
    virtualHosts."hass.kaliwe.ru" = {
      forceSSL = true;
      enableACME = true;
      extraConfig = ''
        proxy_buffering off;
      '';
      locations."/" = {
        proxyPass = "http://[::1]:8123";
        proxyWebsockets = true;
      };
    };
  };
}
