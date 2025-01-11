{pkgs, ...}: {
  environment.systemPackages = [pkgs.pgloader];
  services = {
    postgresql = {
      enable = true;
      dataDir = "/var/lib/postgresql/16";
      package = pkgs.postgresql_16;
      enableTCPIP = true;
      authentication = ''
        # "local" is for Unix domain socket connections only
        local   all             all                                     trust
        # IPv4 local connections:
        host    all             all             127.0.0.1/32            trust
        host    all             all             0.0.0.0/0               password
        # IPv6 local connections:
        host    all             all             ::1/128                 trust
        # Allow replication connections from localhost, by a user with the
        # replication privilege.
        local   replication     all                                     trust
        host    replication     all             127.0.0.1/32            trust
        host    replication     all             ::1/128                 trust
      '';
    };
  };
}
