{config, ...}: {
  sops.secrets."homepage-dashboard" = {};

  services.homepage-dashboard = {
    enable = true;
    listenPort = 8088;
    allowedHosts = "home.pltanton.dev";
    environmentFile = config.sops.secrets."homepage-dashboard".path;
    settings = {
      statusStyle = "dot";
      layout = {
        "Multimedia" = {
          style = "row";
          columns = 3;
          useEqualHeights = true;
        };
      };
    };

    widgets = [
      {
        resources = {
          cpu = true;
          disk = ["/" "/media/archive" "/media/store"];
          memory = true;
        };
      }
    ];
    services = [
      {
        "Multimedia" = [
          {
            "Jellyfin" = {
              icon = "jellyfin.png";
              description = "Manage media servers";
              href = "https://jellyfin.kaliwe.ru";
              siteMonitor = "https://jellyfin.kaliwe.ru";
              widgets = [
                {
                  type = "jellyfin";
                  url = "http://localhost:8096";
                  key = "{{HOMEPAGE_VAR_JELLYFIN}}";
                }
              ];
            };
          }
          {
            "Radarr" = {
              icon = "radarr.png";
              description = "Track and download movies";
              href = "https://radarr.pltanton.dev";
              siteMonitor = "https://radarr.pltanton.dev";
              widgets = [
                {
                  type = "radarr";
                  url = "http://localhost:${toString config.services.radarr.settings.server.port}";
                  key = "{{HOMEPAGE_VAR_RADARR}}";
                }
              ];
            };
          }
          {
            "Sonarr" = {
              icon = "sonarr.png";
              description = "Track and download tv-shows";
              href = "https://sonarr.pltanton.dev";
              siteMonitor = "https://sonarr.pltanton.dev";
              widgets = [
                {
                  type = "sonarr";
                  url = "http://localhost:${toString config.services.sonarr.settings.server.port}";
                  key = "{{HOMEPAGE_VAR_SONARR}}";
                }
              ];
            };
          }
          {
            "Prowlarr" = {
              icon = "prowlarr.png";
              description = "Manage torrent indexers";
              href = "https://prowlarr.pltanton.dev";
              siteMonitor = "https://prowlarr.pltanton.dev";
              widgets = [
                {
                  type = "prowlarr";
                  url = "http://localhost:${toString config.services.prowlarr.settings.server.port}";
                  key = "{{HOMEPAGE_VAR_PROWLARR}}";
                  numberOfFailGrabs = false;
                  numberOfFailQueries = false;
                }
              ];
            };
          }
          {
            "Transmission" = {
              icon = "transmission.png";
              description = "Manage torrents";
              href = "https://torrent.kaliwe.ru";
              siteMonitor = "https://torrent.kaliwe.ru";
              widgets = [
                {
                  type = "transmission";
                  url = "http://127.0.0.1:9091";
                  rpcUrl = "/transmission/";
                  username = "{{HOMEPAGE_VAR_TRANSMISSION_USERNAME}}";
                  password = "{{HOMEPAGE_VAR_TRANSMISSION_PASSWORD}}";
                }
              ];
            };
          }
          {
            "Kavita" = {
              icon = "kavita.png";
              description = "Manage books and comics";
              href = "https://kavita.pltanton.dev";
              siteMonitor = "https://kavita.pltanton.dev";
              widgets = [
                {
                  type = "kavita";
                  url = "http://127.0.0.1:${toString config.services.kavita.settings.Port}";
                  username = "{{HOMEPAGE_VAR_KAVITA_USERNAME}}";
                  password = "{{HOMEPAGE_VAR_KAVITA_PASSWORD}}";
                }
              ];
            };
          }
        ];
      }
      {
        "Home and finances" = [
          {
            "Home Assistant" = {
              icon = "home-assistant.png";
              description = "Home automation";
              href = "https://hass.kaliwe.ru/";
              siteMonitor = "https://hass.kaliwe.ru";
            };
          }
          {
            "Firefly III" = {
              icon = "firefly-iii.png";
              description = "Manage finances";
              href = "https://firefly.kaliwe.ru/";
              siteMonitor = "https://firefly.kaliwe.ru";
            };
          }
          {
            "Frigate" = {
              icon = "frigate.png";
              description = "Manage cameras";
              href = "https://frigate.pltanton.dev";
              siteMonitor = "https://frigate.pltanton.dev";
            };
          }
        ];
      }
      {
        "Cloud" = [
          {
            "Nextcloud" = {
              icon = "nextcloud.png";
              description = "Manage files";
              href = "https://nextcloud.kaliwe.ru";
              siteMonitor = "https://nextcloud.kaliwe.ru";
              widgets = [
                {
                  type = "nextcloud";
                  url = "https://nextcloud.kaliwe.ru";
                  username = "{{HOMEPAGE_VAR_NEXTCLOUD_USERNAME}}";
                  password = "{{HOMEPAGE_VAR_NEXTCLOUD_PASSWORD}}";
                }
              ];
            };
          }
          {
            "Dawarich" = {
              icon = "dawarich.png";
              description = "Manage geo-tracking data";
              href = "https://dawarich.pltanton.dev/";
              siteMonitor = "https://dawarich.pltanton.dev";
            };
          }
          {
            "Vaultwarden" = {
              icon = "vaultwarden.png";
              description = "Manage passwords";
              href = "https://vaultwarden.pltanton.dev/";
              siteMonitor = "https://vaultwarden.pltanton.dev";
            };
          }
        ];
      }
      {
        "Dev" = [
          {
            "Gitea" = {
              icon = "gitea.png";
              description = "Manage code";
              href = "https://gitea.kaliwe.ru/";
              siteMonitor = "https://gitea.kaliwe.ru";
            };
          }
          {
            "Woodpecker" = {
              icon = "woodpecker.png";
              description = "Manage CI";
              href = "https://ci.kaliwe.ru/";
              siteMonitor = "https://ci.kaliwe.ru";
            };
          }
          {
            "Grafana" = {
              icon = "grafana.png";
              description = "Metrics and monitoring";
              href = "https://grafana.kaliwe.ru/";
              siteMonitor = "https://grafana.kaliwe.ru";
            };
          }
          {
            "XUI Russia" = {
              icon = "xray.png";
              description = "Xray UI";
              href = "https://xui.sprintbox.pltanton.dev/";
              siteMonitor = "https://xui.sprintbox.pltanton.dev";
            };
          }
          {
            "XUI EU" = {
              icon = "xray.png";
              description = "Xray UI";
              href = "https://xui.hz1.pltanton.dev/";
              siteMonitor = "https://xui.hz1.pltanton.dev";
            };
          }
        ];
      }
    ];
  };

  services.caddy.virtualHosts."home.pltanton.dev".extraConfig = ''
    basicauth / {
      admin $2a$14$srxQiRhlA33qFcC6ANBEZ.YtFvzXBxzBO/TY41oI1.AA.ltubP0Dm
    }
    reverse_proxy http://127.0.0.1:${toString config.services.homepage-dashboard.listenPort}
  '';
}
