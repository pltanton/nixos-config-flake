{
  config,
  pkgs,
  lib,
  ...
}: let
  consts = import ../constants.nix;
in {
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
      enable = false;
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

      "calibre.pltanton.dev".extraConfig = ''
        reverse_proxy http://::1:${toString config.services.calibre-web.listen.port}
      '';
    };
  };
}
