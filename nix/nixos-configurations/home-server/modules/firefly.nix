{
  pkgs,
  config,
  lib,
  ...
}: {
  sops.secrets."firefly/key".owner = config.services.firefly-iii.user;

  services.firefly-iii = {
    enable = true;
    inherit (config.services.caddy) user;
    settings = {
      APP_URL = "https://firefly.kaliwe.ru";
      APP_KEY_FILE = config.sops.secrets."firefly/key".path;
      DB_CONNECTION = "pgsql";
      DB_HOST = "localhost";
      DB_DATABASE = "firefly-iii";
      DB_USERNAME = config.services.firefly-iii.user;
      APP_ENV = "production";
      ALLOW_WEBHOOKS = "true";
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
    max_execution_time=3600
  '';

  services.firefly-iii-data-importer = {
    enable = true;
    inherit (config.services.firefly-iii) user;
    settings = {
      FIREFLY_III_URL = "https://firefly.kaliwe.ru";
      IMPORT_DIR_ALLOWLIST = dirOf config.sops.secrets."firefly/gocardless-config".path;
      FIREFLY_III_ACCESS_TOKEN_FILE = config.sops.secrets."firefly/access-token".path;
      NORDIGEN_ID_FILE = config.sops.secrets."firefly/nordigen-id".path;
      NORDIGEN_KEY_FILE = config.sops.secrets."firefly/nordigen-key".path;
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
      basicauth / {
        anton $2a$14$a60.ZB7Synyo5AjfCAh1R.Qc8xIMLmPC7DBeWpSfZ83ZGWHnvZh6C
      }
    '';
  };
  systemd.timers."firefly-iii-data-importer-job" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "*-*-* 19:00:00";
      Persistent = true;
      Unit = "firefly-iii-data-importer-job.service";
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
      ${artisan} importer:import ${config.sops.secrets."firefly/gocardless-config".path}
      ${artisan} importer:import ${config.sops.secrets."firefly/revolut-config".path}
    '';

    serviceConfig = {
      ReadWritePaths = [config.services.firefly-iii-data-importer.dataDir];
      Type = "oneshot";
      User = config.services.firefly-iii.user;
    };
  };

  sops.secrets."firefly/boc-fixer-env" = {};
  services.firefly-iii-boc-fixer = {
    enable = true;
    settings = {
      FIREFLY_BOC_FIXER_PORT = "3300";
      LOG_LEVEL = "DEBUG";
      FIREFLY_URL = "https://firefly.kaliwe.ru";
    };
    environmentFile = config.sops.secrets."firefly/boc-fixer-env".path;
  };
}
