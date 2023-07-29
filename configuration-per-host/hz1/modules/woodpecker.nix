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

  services.caddy.virtualHosts."ci.kaliwe.ru".extraConfig = ''
    reverse_proxy http://127.0.0.1:3030
  '';
}
