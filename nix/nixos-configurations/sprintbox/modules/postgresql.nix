{
  config,
  pkgs,
  ...
}: {
  services = {
    postgresql = {
      enable = true;
      dataDir = "/var/lib/postgresql/14";
      package = pkgs.postgresql_14;

      ensureDatabases = ["vaultwarden"];
      ensureUsers = [
        {
          name = "vaultwarden";
          # ensurePermissions = { "DATABASE vaultwarden" = "ALL PRIVILEGES"; };
        }
      ];

      # enableTCPIP = true;

      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all ::1/128 trust
        host  all  all 0.0.0.0/0 md5
      '';
    };
  };
}
