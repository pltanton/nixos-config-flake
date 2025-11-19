{
  config,
  pkgs,
  lib,
  ...
}: let
  consts = import ../constants.nix;
in {
  virtualisation.oci-containers.containers.calibre-web-automated-book-downloader = {
    image = "crocodilestick/calibre-web-automated:latest";
    ports = ["4233:8083"];
    autoStart = true;
    # environment = {
    # };
    volumes = [
      "${consts.mediaAppHomes}/cwa/ingest:/cwa-book-ingest"
      "${consts.mediaAppHomes}/cwa/library:/calibre-library"
      "${consts.mediaAppHomes}/cwa/config:/config"
    ];

    #extraOptions = [ "--network=traefik_proxy" ];
  };

  virtualisation.oci-containers.containers.kosync = {
    image = "koreader/kosync:latest";
    autoStart = true;
    ports = ["127.0.0.1:7200:7200"];
    volumes = [
      "/var/lib/redis-kosync:/var/lib/redis"
    ];
  };

  services = {
    calibre-web = {
      package = pkgs.stable.calibre-web;
      enable = true;
      dataDir = "${consts.archiveMountPoint}/calibre/data";
      options = {
        calibreLibrary = "${consts.archiveMountPoint}/calibre/library";
        enableBookUploading = true;
      };
    };

    caddy.virtualHosts = lib.mkIf config.services.calibre-web.enable {
      "kosync.pltanton.dev".extraConfig = ''

        reverse_proxy * 127.0.0.1:7200 {
          transport http {
            tls_insecure_skip_verify
          }
        }
      '';

      # reverse_proxy http://localhost:${toString config.services.calibre-web.listen.port}
      "calibre.pltanton.dev".extraConfig = ''
        reverse_proxy http://localhost:4233
      '';
    };
  };
}
