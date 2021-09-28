{ pkgs, config, ... }:

{
  # networking.firewall.allowedTCPPorts = [ 3030 ];

  systemd.services.drone-server = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      EnvironmentFile = [ "/home/deploy/drone-server-secrets.env" ];
      Environment = [
        "DRONE_DATABASE_DATASOURCE=postgres:///drone?host=/run/postgresql"
        "DRONE_DATABASE_DRIVER=postgres"
        "DRONE_SERVER_PORT=:3030"
        "DRONE_SERVER_HOST=drone.kaliwe.ru"
        "DRONE_SERVER_PROTO=https"
      ];
      ExecStart = "${pkgs.drone}/bin/drone-server";
      User = "deploy";
      Group = "deploy";
    };
  };

  services.postgresql = {
    ensureDatabases = [ "drone" ];
    ensureUsers = [{
      name = "deploy";
      ensurePermissions = { "DATABASE drone" = "ALL PRIVILEGES"; };
    }];
  };

  services.nginx = {
    enable = true;
    virtualHosts."drone.kaliwe.ru" = {
      enableACME = true;
      forceSSL = true;

      locations."/".proxyPass = "http://127.0.0.1:3011";
    };
  };
}
