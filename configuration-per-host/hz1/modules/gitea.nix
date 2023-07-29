{ config, pkgs, ... }:

{
  services = {
    gitea = {
      enable = true;
      httpPort = 3003;
      domain = "gitea.kaliwe.ru";
      rootUrl = "https://gitea.kaliwe.ru";
      database = {
        type = "postgres";
        passwordFile = "/secrets/gitea-database";
      };
    };
  };

  services.caddy.virtualHosts."gitea.kaliwe.ru".extraConfig = ''
    reverse_proxy http://127.0.0.1:3003
  '';
}
