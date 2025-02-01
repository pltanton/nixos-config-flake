{pkgs, ...}: {
  imports = [./configuration/notifications.nix];

  services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      "met"
      "radio_browser"
      "homekit"
      "homekit_controller"
      "xiaomi"
      "qingping"
    ];

    customComponents = [pkgs.home-assistant-custom-components.xiaomi_miot];

    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
      http = {
        # server_host = "::1";
        trusted_proxies = ["::1"];
        use_x_forwarded_for = true;
      };

      telegram_bot = [
        {
          platform = "polling";
          api_key = "!secret tg_bot_api_key";
          allowed_chat_ids = [
            "!secret tg_notifications_channel"
          ];
        }
      ];

      # recorder.db_url = "postgresql://@/hass";
    };
    package = pkgs.home-assistant.override {
      extraPackages = ps:
        with ps; [
          spotifyaio
          spotipy
          psycopg2
          paho-mqtt
          getmac
          huawei-lte-api
          url-normalize
          qingping-ble
          pychromecast
          aiohomekit
          pyipp
        ];
    };
  };

  sops.secrets."home-assistant-secrets" = {
    owner = "hass";
    path = "/var/lib/hass/secrets.yaml";
    restartUnits = ["home-assistant.service"];
  };

  services.caddy = {
    virtualHosts."hass.kaliwe.ru".extraConfig = ''
      reverse_proxy http://[::1]:8123
    '';
  };
}
