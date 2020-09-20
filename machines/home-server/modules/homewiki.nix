{ config, pkgs, ... }:

let secrets = import ../secrets.nix;
in {
  environment.systemPackages = with pkgs; [ hugo ];

  services.nginx = {
    enable = true;

    virtualHosts."homewiki.kaliwe.ru" = {
      enableACME = true;
      forceSSL = true;
      basicAuthFile = secrets.files.homewiki.destination;
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
