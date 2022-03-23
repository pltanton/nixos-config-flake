{ pkgs, config, ... }:
let consts = import ../constants.nix;
in {
  virtualisation.oci-containers.containers = {
    onlyoffice-documentserver = {
      image = "onlyoffice/documentserver";
      ports = [ "8901:80" ];
      # extraOptions = [ "--network=host" ];
      environment = {
        # ONLYOFFICE_HTTPS_HSTS_ENABLED = "false";
        # USE_UNAUTHORIZED_STORAGE = "true";
      };
      volumes = [
        "${consts.mediaAppHomes}/onlyoffice-home/data:/var/www/onlyoffice/Data"
        "${consts.mediaAppHomes}/onlyoffice-home/logs:/var/log/onlyoffice"
      ];
    };
  };

  services.nginx = {
    virtualHosts."onlyoffice.kaliwe.ru" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://localhost:8901";
        proxyWebsockets = false;

        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Real-IP $remote_addr;
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          proxy_set_header X-Forwarded-Proto $scheme;
          proxy_redirect off;
        '';
      };
    };
  };
}
