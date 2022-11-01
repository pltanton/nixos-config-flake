{ config, pkgs, secrets, ... }:

{
  services = {
    vaultwarden = {
      enable = true;
      dbBackend = "postgresql";
      config = {
        domain = "https://bitwarden.kaliwe.ru";
        signupsAllowed = true;
        databaseUrl = "postgresql://vaultwarden@localhost/vaultwarden";
        #enableDbWal = false;
        #extendedLogging = true;
        rocketPort = 8222;
      };
      environmentFile = "/root/vaultvarden.env";
    };
  };

  services.nginx = {
    virtualHosts."bitwarden.kaliwe.ru" = {
      enableACME = true;
      forceSSL = true;
      locations."/".proxyPass = "http://127.0.0.1:8222";
    };
  };

  security.acme.certs = {
    "bitwarden.kaliwe.ru".email = "plotnikovanton@gmail.com";
  };
}
