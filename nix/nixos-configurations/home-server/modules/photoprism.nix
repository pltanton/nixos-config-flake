{config, ...}: let
  consts = import ../constants.nix;
in {
  sops.secrets."photoprism" = {};



  fileSystems = {
    "${config.services.photoprism.originalsPath}/Anton" = {
      device = "${config.services.nextcloud.home}/data/anton/files/InstantUpload/Camera";
      options = ["bind"];
    };

    "${config.services.photoprism.originalsPath}/Photo" = {
      device = "${consts.archiveMountPoint}/archive/photo";
      options = ["bind" "ro"];
    };
  };

  users.groups.nextcloud.members = ["photoprism"];
  users.groups.privatestore.members = ["photoprism"];

  services = {
    photoprism = {
      enable = true;
      originalsPath = "${consts.archiveMountPoint}/photoprism-data";
      passwordFile = config.sops.secrets."photoprism".path;
      settings = {
        PHOTOPRISM_ADMIN_USER = "anton";
        PHOTOPRISM_DATABASE_DRIVER = "mysql";
        PHOTOPRISM_DATABASE_NAME = "photoprism";
        PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
        PHOTOPRISM_DATABASE_USER = "photoprism";
        PHOTOPRISM_SITE_URL = "https://photoprism.pltanton.dev";
        PHOTOPRISM_INDEX_SCHEDULE = "@every 3h";
      };
    };

    mysql = {
      ensureDatabases = ["photoprism"];
      ensureUsers = [
        {
          name = "photoprism";
          ensurePermissions = {
            "photoprism.*" = "ALL PRIVILEGES";
          };
        }
      ];
    };

    caddy.virtualHosts."photoprism.pltanton.dev".extraConfig = ''
      reverse_proxy http://127.0.0.1:${toString config.services.photoprism.port}
    '';
  };
}
