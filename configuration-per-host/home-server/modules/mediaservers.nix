{ config, pkgs, ... }:

let
  consts = import ../constants.nix;
  secrets = import ../secrets.nix;
in {
  virtualisation.oci-containers.containers = {
    monitorrent = {
      image = "werwolfby/alpine-monitorrent";
      ports = [ "6687:6687" ];
      extraOptions = [ "--network=host" ];
      volumes = [
        "${consts.mediaAppHomes}/monitorrent-home/monitorrent.db:/var/www/monitorrent/monitorrent.db"
      ];
    };
  };

  services = {
    jellyfin = {
      enable = true;
      group = "publicstore";
      user = "publicstore";
    };

    syncplay = { enable = true; };

    nginx.virtualHosts = {
      "jellyfin.kaliwe.ru" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyWebsockets = true;
          proxyPass = "http://localhost:8096";
          extraConfig = ''
            proxy_set_header X-Real-IP         $remote_addr;
            proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Host  $host;
            proxy_set_header Host              $host;
          '';
        };
      };

      "monitorrent.kaliwe.ru" = {
        enableACME = true;
        forceSSL = true;
        locations."/" = {
          proxyPass = "http://localhost:6687";
          extraConfig = ''
            proxy_set_header X-Real-IP         $remote_addr;
            proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Host  $host;
            proxy_set_header Host              $host;
            proxy_max_temp_file_size           0;
          '';
        };
      };
    };
  };
}
