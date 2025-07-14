{pkgs, ...}: {
  environment.systemPackages = [pkgs.pgloader];
  services = {
    postgresql = {
      enable = true;
      dataDir = "/var/lib/postgresql/16";
      package = pkgs.postgresql_16;
      enableTCPIP = true;

      ensureDatabases = ["vaultwarden"];
      ensureUsers = [
        {
          name = "vaultwarden";
          ensureDBOwnership = true;
        }
      ];
    };
  };
}
