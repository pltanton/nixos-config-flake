{
  config,
  pkgs,
  ...
}: {
  services = {
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

    postgresql = {
      enable = true;
      package = pkgs.stable.postgresql_17;
      extensions = ps: with ps; [postgis];

      ensureDatabases = ["nextcloud" "hass"];
      # ensureDatabases = ["nextcloud" "hass"];
      ensureUsers = [
        {
          name = "nextcloud";
          # ensureDBOwnership = true;
        }
        {
          name = "hass";
          # ensureDBOwnership = true;
        }
      ];

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

  environment.systemPackages = [
    # pkgs.postgresql_17
    (let
      # XXX specify the postgresql package you'd like to upgrade to.
      # Do not forget to list the extensions you need.
      newPostgres = pkgs.postgresql_17.withPackages (_pp: [
        # pp.plv8
      ]);
    in
      pkgs.writeScriptBin "upgrade-pg-cluster" ''
        set -eux
        # XXX it's perhaps advisable to stop all services that depend on postgresql
        systemctl stop postgresql

        export NEWDATA="/var/lib/postgresql/${newPostgres.psqlSchema}"
        export NEWBIN="${newPostgres}/bin"

        export OLDDATA="${config.services.postgresql.dataDir}"
        export OLDBIN="${config.services.postgresql.package}/bin"

        install -d -m 0700 -o postgres -g postgres "$NEWDATA"
        cd "$NEWDATA"
        sudo -u postgres $NEWBIN/initdb -D "$NEWDATA"

        sudo -u postgres $NEWBIN/pg_upgrade \
          --old-datadir "$OLDDATA" --new-datadir "$NEWDATA" \
          --old-bindir $OLDBIN --new-bindir $NEWBIN \
          "$@"
      '')
  ];
}
