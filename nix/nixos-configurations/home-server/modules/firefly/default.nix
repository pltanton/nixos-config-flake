{
  pkgs,
  config,
  ...
}: {
  imports = [./firefly-iii-data-importer.nix];

  sops.secrets."firefly/key" = {
    owner = config.services.firefly-iii.user;
  };
  services.firefly-iii = {
    enable = true;
    user = config.services.caddy.user;
    settings = {
      APP_URL = "https://firefly.kaliwe.ru";
      APP_KEY_FILE = config.sops.secrets."firefly/key".path;
      DB_CONNECTION = "pgsql";
      DB_HOST = "localhost";
      DB_DATABASE = "firefly-iii";
      DB_USERNAME = config.services.firefly-iii.user;
      APP_ENV = "production";
    };
  };

  services.postgresql = let
    inherit (config.services.firefly-iii) settings;
  in {
    ensureDatabases = [settings.DB_DATABASE];
    ensureUsers = [
      {
        name = settings.DB_USERNAME;
      }
    ];
  };

  services.phpfpm.pools.firefly-iii-data-importer.phpOptions = ''
    max_execution_time=600
  '';
  services.firefly-iii-data-importer = {
    enable = true;
    package = pkgs.firefly-iii-data-importer.override (prev: {
      dataDir = config.services.firefly-iii-data-importer.dataDir;
    });
    settings = {
      # APP_DEBUG = true;
      # LOG_LEVEL = "debug";
      FIREFLY_III_URL = "https://firefly.kaliwe.ru";
      FIREFLY_III_CLIENT_ID = "4";
      # FIREFLY_III_ACCESS_TOKEN_FILE = config.sops.secrets.firefly-data-importer-oauth-token.path;
    };
  };

  services.caddy.virtualHosts = {
    "firefly.kaliwe.ru".extraConfig = ''
      encode gzip
      file_server
      root * ${config.services.firefly-iii.package}/public
      php_fastcgi unix/${config.services.phpfpm.pools.firefly-iii.socket}
    '';

    "firefly-data-importer.kaliwe.ru".extraConfig = ''
      encode gzip
      file_server
      root * ${config.services.firefly-iii-data-importer.package}/public
      php_fastcgi unix/${config.services.phpfpm.pools.firefly-iii-data-importer.socket}
    '';
  };
  systemd.timers."firefly-iii-data-importer-job" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "*-*-* 19:00:00";
      Persistent = true;
      Unit = "hello-world.service";
    };
  };


  sops.secrets."firefly/access-token".owner = config.services.firefly-iii.user;
  sops.secrets."firefly/nordigen-id".owner = config.services.firefly-iii.user;
  sops.secrets."firefly/nordigen-key".owner = config.services.firefly-iii.user;
  sops.secrets."firefly/gocardless-config".owner = config.services.firefly-iii.user;
  sops.secrets."firefly/revolut-config".owner = config.services.firefly-iii.user;
  systemd.services."firefly-iii-data-importer-job" = let
    artisan = "${config.services.firefly-iii-data-importer.package}/artisan";
  in {
    script = ''
      set -eu

      set -a
      FIREFLY_III_ACCESS_TOKEN="$(< ${config.sops.secrets."firefly/access-token".path})"
      FIREFLY_III_URL=${config.services.firefly-iii-data-importer.settings.FIREFLY_III_URL}

      NORDIGEN_ID="$(< ${config.sops.secrets."firefly/nordigen-id".path})"
      NORDIGEN_KEY="$(< ${config.sops.secrets."firefly/nordigen-key".path})"

      IMPORT_DIR_ALLOWLIST="$(dirname ${config.sops.secrets."firefly/gocardless-config".path})"
      set +a

      ${artisan} importer:import ${config.sops.secrets."firefly/gocardless-config".path}
      ${artisan} importer:import ${config.sops.secrets."firefly/revolut-config".path}
    '';

    serviceConfig = {
      Type = "oneshot";
      User = config.services.firefly-iii.user;
    };
  };
}
