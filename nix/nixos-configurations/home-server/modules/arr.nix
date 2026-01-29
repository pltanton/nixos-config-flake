{
  config,
  lib,
  ...
}: {
  services = {
    prowlarr = {
      enable = true;
    };

    sonarr = {
      enable = true;
    };

    radarr = {
      enable = true;
    };

    readarr = {
      enable = true;
    };

    caddy.virtualHosts = {
      "prowlarr.pltanton.dev".extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString config.services.prowlarr.settings.server.port}
      '';

      "sonarr.pltanton.dev".extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString config.services.sonarr.settings.server.port}
      '';

      "radarr.pltanton.dev".extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString config.services.radarr.settings.server.port}
      '';

      "readarr.pltanton.dev".extraConfig = ''
        reverse_proxy http://127.0.0.1:${toString config.services.readarr.settings.server.port}
      '';
    };
  };

  systemd.tmpfiles.rules = lib.mkIf config.services.sonarr.enable [
    "d /media/store/media/downloads/sonarr 0775 sonarr publicstore"
    "d /media/store/media/sonarr 0775 sonarr publicstore"
    "d /media/store/media/downloads/radarr 0775 radarr publicstore"
    "d /media/store/media/radarr 0775 radarr publicstore"
  ];

  users = {
    groups = {
      publicstore.members = [
        config.services.sonarr.user
        config.services.radarr.user
      ];
    };
  };
}
