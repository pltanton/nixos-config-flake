{ config, pkgs, ... }:
{
  services.nginx = {
    enable = true;
    virtualHosts."_" = {
      enableACME = true;
      forceSSL = true;

      locations."/".proxyPass = "http://127.0.0.1:3000";
    };
  };
}
