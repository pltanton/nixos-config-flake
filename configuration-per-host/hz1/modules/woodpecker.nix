{ pkgs, ... }:

{
  services.woodpecker-server = {
    enable = true;
    admins = "pltanton";
    database.type = "postgres";
    giteaClientIdFile = "/var/lib/woodpecker-server/gitea-client-id";
    giteaClientSecretFile = "/var/lib/woodpecker-server/gitea-client-secret";
    rootUrl = "https://ci.kaliwe.ru";
  };

  services.nginx = {
    enable = true;
    virtualHosts."ci.kaliwe.ru" = {
      enableACME = true;
      forceSSL = true;

      locations."/".proxyPass = "http://127.0.0.1:3030";
    };
  };
}
