{pkgs, ...}: {
  services.woodpecker-server = {
    enable = true;
    package = pkgs.unstable.woodpecker-server;
    environment = {
      WOODPECKER_ADMIN = "pltanton";
      WOODPECKER_HOST = "https://ci.kaliwe.ru";
      WOODPECKER_DATABASE_DRIVER = "postgres";
      WOODPECKER_SERVER_ADDR = ":3030";

      WOODPECKER_DATABASE_DATASOURCE = "postgres://woodpecker-server@/woodpecker_server?host=/run/postgresql";

      WOODPECKER_OPEN = "true";

      WOODPECKER_GITEA = "true";
      WOODPECKER_GITEA_URL = "https://gitea.kaliwe.ru";
      WOODPECKER_GITEA_SKIP_VERIFY = "false";
      WOODPECKER_GITEA_CLIENT_FILE = "/var/lib/woodpecker-server/gitea-client-id";
      WOODPECKER_GITEA_SECRET_FILE = "/var/lib/woodpecker-server/gitea-client-secret";
      WOODPECKER_AGENT_SECRET = "d03db2f4cc46104075afc8261633e9dee26df3b701009e49b4800f35df5a2e36";
    };
  };

  networking.firewall.allowedTCPPorts = [9000];
  networking.firewall.allowedUDPPorts = [9000];

  # services.postgresql = {
  #   ensureDatabases = [ "woodpecker_server" ];
  #   ensureUsers = [{
  #     name = "woodpecker-server";
  #     ensurePermissions = { "DATABASE woodpecker_server" = "ALL PRIVILEGES"; };
  #   }];
  # };

  services.woodpecker-agents.agents = {
    docker = {
      enable = false;
      package = pkgs.unstable.woodpecker-agent;

      environment = {
        # DOCKER_HOST = "unix:///run/podman/podman.sock";
        WOODPECKER_LOG_LEVEL = "debug";
        WOODPECKER_BACKEND = "docker";
        WOODPECKER_SERVER = "127.0.0.1:9000";
        WOODPECKER_HOSTNAME = "ci.kaliwe.ru";
        WOODPECKER_AGENT_SECRET = "d03db2f4cc46104075afc8261633e9dee26df3b701009e49b4800f35df5a2e36";
      };
      extraGroups = ["docker"];
    };
  };

  services.caddy.virtualHosts."ci.kaliwe.ru".extraConfig = ''
    reverse_proxy localhost:3030
  '';
}
