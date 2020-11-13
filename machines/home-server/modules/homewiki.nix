{ config, pkgs, secrets, ... }:

{
  environment.systemPackages = with pkgs; [ hugo ];

  services.nginx = {
    enable = true;

    virtualHosts."homewiki.kaliwe.ru" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        root = "/var/lib/homewiki/current";
      };
    };
  };
}
