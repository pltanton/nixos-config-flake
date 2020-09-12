{ config, pkgs, ... }:

{
  services = {
    gitea = {
      enable = true;
	  domain = "gitea.kaliwe.ru";
	  rootUrl = "https://gitea.kaliwe.ru";
      database = {
        type = "postgres";
        passwordFile = "/secrets/gitea-database";
      };
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts."gitea.kaliwe.ru" = {
      enableACME = true;
      forceSSL = true;

      locations."/".proxyPass = "http://127.0.0.1:3000";
    };
  };

  security.acme.certs = {
    "gitea.kaliwe.ru".email = "plotnikovanton@gmail.com";
  };
}
