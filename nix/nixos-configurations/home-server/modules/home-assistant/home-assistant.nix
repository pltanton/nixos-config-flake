{
  config,
  pkgs,
  ...
}: {
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
      default_config = {};

      http = {
        # server_host = "::1";
        trusted_proxies = ["::1"];
        use_x_forwarded_for = true;
      };

      # recorder.db_url = "postgresql://@/hass";
    };
    package = pkgs.home-assistant.override {
      extraPackages = ps:
        with ps; [
          spotipy
          psycopg2
          paho-mqtt
          getmac
          huawei-lte-api
          url-normalize
          qingping-ble
        ];
    };
  };

  services.caddy = {
    virtualHosts."hass.kaliwe.ru".extraConfig = ''
      reverse_proxy http://[::1]:8123
    '';
  };
}
