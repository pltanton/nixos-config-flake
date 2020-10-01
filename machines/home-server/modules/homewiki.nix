{ config, pkgs, secrets, ... }:

{
  environment.systemPackages = with pkgs; [ hugo ];

  services.nginx = {
    enable = true;

    virtualHosts."homewiki.kaliwe.ru" = {
      enableACME = true;
      forceSSL = true;
      basicAuth = {
        admin = secrets.homewikipass;
      };
      extraConfig = ''
        satisfy any;
        allow 192.168.0.0/16;
        deny all;
      '';
      locations."/" = {
        root = "/var/lib/homewiki/current";
      };
    };
  };
}
