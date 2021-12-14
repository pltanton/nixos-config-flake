{ config, pkgs, ... }:

{
  services = {
    bitwarden_rs = {
      enable = true;
      config = {
        domain = "https://bitwarden.kaliwe.ru";
        signupsAllowed = true;
        #databaseUrl = "postgresql://bitwarden:bitwarden@localhost/bitwarden";
        #enableDbWal = false;
        #extendedLogging = true;
        rocketPort = 8222;
      };
    };
  };

  services.nginx = {
    enable = true;
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
