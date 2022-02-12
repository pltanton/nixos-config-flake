{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.postgresql_11 ];
  services = {
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

    postgresql = {
      enable = true;
      dataDir = "/var/lib/postgresql/11";
      package = pkgs.postgresql_11;

      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [{
        name = "nextcloud";
        ensurePermissions = { "DATABASE nextcloud" = "ALL PRIVILEGES"; };
      }];

      enableTCPIP = true;

      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all ::1/128 trust
        host  all  all 0.0.0.0/0 md5
      '';

      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE ROLE root WITH CREATEDB;
        CREATE DATABASE root;
        GRANT ALL PRIVILEGES ON SCHEMA public TO root;
      '';
    };
  };
}
