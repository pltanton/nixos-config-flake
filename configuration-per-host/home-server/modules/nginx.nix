{ config, pkgs, ... }:
{
  services.nginx = {
    enable = true;

    virtualHosts."home.kaliwe.ru" = {
      enableACME = true;
      forceSSL = true;
      locations."/".proxyPass = "http://192.168.88.1:88";
    };
  };

  security.acme.email = "plotnikovanton@gmail.com";
}
