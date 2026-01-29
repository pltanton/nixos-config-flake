# Auto-generated using compose2nix v0.3.1.
#
# DB and redis docker services replaced with local nixos services.
# Note: postgis extension in dawarich database must be created manually, because it requires SUPERUSER access.
#
# TODO: replace docker mounts with system mountpoint?
{
  pkgs,
  lib,
  ...
}: let
  env = {
    "APPLICATION_HOSTS" = "dawarich.pltanton.dev,127.0.0.1";
    "APPLICATION_PROTOCOL" = "http";

    "DATABASE_HOST" = "172.17.0.1";
    "DATABASE_NAME" = "dawarich";
    "DATABASE_PASSWORD" = "dawarich";
    "DATABASE_PORT" = "5432";
    "DATABASE_USERNAME" = "dawarich";

    "SELF_HOSTED" = "true";
    "DISTANCE_UNIT" = "km";
    "MIN_MINUTES_SPENT_IN_CITY" = "60";
    "PROMETHEUS_EXPORTER_ENABLED" = "false";
    "RAILS_ENV" = "production";
    "RAILS_LOG_TO_STDOUT" = "true";
    "REDIS_URL" = "redis://172.17.0.1:6380/0";
    "SECRET_KEY_BASE" = "1234567890";
    "TIME_ZONE" = "Asia/Nicosia";
  };
in {
  services = {
    redis.servers.dawarich = {
      enable = true;
      port = 6380;
      bind = "172.17.0.1";
      settings = {
        protected-mode = "no";
      };
    };

    postgresql = {
      ensureDatabases = ["dawarich"];
      ensureUsers = [
        {
          name = "dawarich";
          ensureDBOwnership = true;
        }
      ];
    };

    caddy.virtualHosts."dawarich.pltanton.dev".extraConfig = ''
      reverse_proxy http://127.0.0.1:3003
    '';
  };

  # Containers
  virtualisation.oci-containers.containers = {
    "dawarich_app" = {
      image = "freikin/dawarich:latest";
      environment = env;
      volumes = [
        "dawarich_dawarich_public:/var/app/public:rw"
        "dawarich_dawarich_storage:/var/app/storage:rw"
        "dawarich_dawarich_watched:/var/app/tmp/imports/watched:rw"
      ];
      ports = [
        "3003:3000/tcp"
      ];
      cmd = ["bin/rails" "server" "-p" "3000" "-b" "::"];
      dependsOn = [
        # "dawarich_redis"
      ];
      log-driver = "journald";
      extraOptions = [
        "--cpus=0.5"
        "--entrypoint=web-entrypoint.sh"
        "--health-cmd=wget -qO - http://127.0.0.1:3000/api/v1/health | grep -q '\"status\"\\s*:\\s*\"ok\"'"
        "--health-interval=10s"
        "--health-retries=30"
        "--health-start-period=30s"
        "--health-timeout=10s"
        "--memory=4294967296b"
        "--network-alias=dawarich_app"
        "--network=dawarich_dawarich"
      ];
    };

    "dawarich_sidekiq" = {
      image = "freikin/dawarich:latest";
      environment = env;
      volumes = [
        "dawarich_dawarich_public:/var/app/public:rw"
        "dawarich_dawarich_storage:/var/app/storage:rw"
        "dawarich_dawarich_watched:/var/app/tmp/imports/watched:rw"
      ];
      cmd = ["bundle" "exec" "sidekiq"];
      dependsOn = [
        "dawarich_app"
        # "dawarich_db"
        # "dawarich_redis"
      ];
      log-driver = "journald";
      extraOptions = [
        "--cpus=0.5"
        "--entrypoint=sidekiq-entrypoint.sh"
        "--health-cmd=bundle exec sidekiqmon processes | grep \${HOSTNAME}"
        "--health-interval=10s"
        "--health-retries=30"
        "--health-start-period=30s"
        "--health-timeout=10s"
        "--memory=4294967296b"
        "--network-alias=dawarich_sidekiq"
        "--network=dawarich_dawarich"
      ];
    };
  };

  systemd = {
    services = {
      "docker-dawarich_app" = {
        serviceConfig = {
          Restart = lib.mkOverride 90 "on-failure";
          RestartMaxDelaySec = lib.mkOverride 90 "1m";
          RestartSec = lib.mkOverride 90 "100ms";
          RestartSteps = lib.mkOverride 90 9;
        };
        after = [
          "docker-network-dawarich_dawarich.service"
          "docker-volume-dawarich_dawarich_public.service"
          "docker-volume-dawarich_dawarich_storage.service"
          "docker-volume-dawarich_dawarich_watched.service"
        ];
        requires = [
          "docker-network-dawarich_dawarich.service"
          "docker-volume-dawarich_dawarich_public.service"
          "docker-volume-dawarich_dawarich_storage.service"
          "docker-volume-dawarich_dawarich_watched.service"
        ];
        partOf = [
          "docker-compose-dawarich-root.target"
        ];
        wantedBy = [
          "docker-compose-dawarich-root.target"
        ];
      };

      "docker-dawarich_sidekiq" = {
        serviceConfig = {
          Restart = lib.mkOverride 90 "on-failure";
          RestartMaxDelaySec = lib.mkOverride 90 "1m";
          RestartSec = lib.mkOverride 90 "100ms";
          RestartSteps = lib.mkOverride 90 9;
        };
        after = [
          "docker-network-dawarich_dawarich.service"
          "docker-volume-dawarich_dawarich_public.service"
          "docker-volume-dawarich_dawarich_storage.service"
          "docker-volume-dawarich_dawarich_watched.service"
        ];
        requires = [
          "docker-network-dawarich_dawarich.service"
          "docker-volume-dawarich_dawarich_public.service"
          "docker-volume-dawarich_dawarich_storage.service"
          "docker-volume-dawarich_dawarich_watched.service"
        ];
        partOf = [
          "docker-compose-dawarich-root.target"
        ];
        wantedBy = [
          "docker-compose-dawarich-root.target"
        ];
      };

      # Networks
      "docker-network-dawarich_dawarich" = {
        path = [pkgs.docker];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStop = "docker network rm -f dawarich_dawarich";
        };
        script = ''
          docker network inspect dawarich_dawarich || docker network create dawarich_dawarich
        '';
        partOf = ["docker-compose-dawarich-root.target"];
        wantedBy = ["docker-compose-dawarich-root.target"];
      };

      # Volumes
      # "docker-volume-dawarich_dawarich_db_data" = {
      #   path = [pkgs.docker];
      #   serviceConfig = {
      #     Type = "oneshot";
      #     RemainAfterExit = true;
      #   };
      #   script = ''
      #     docker volume inspect dawarich_dawarich_db_data || docker volume create dawarich_dawarich_db_data
      #   '';
      #   partOf = ["docker-compose-dawarich-root.target"];
      #   wantedBy = ["docker-compose-dawarich-root.target"];
      # };
      "docker-volume-dawarich_dawarich_public" = {
        path = [pkgs.docker];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          docker volume inspect dawarich_dawarich_public || docker volume create dawarich_dawarich_public
        '';
        partOf = ["docker-compose-dawarich-root.target"];
        wantedBy = ["docker-compose-dawarich-root.target"];
      };
      # "docker-volume-dawarich_dawarich_redis_data" = {
      #   path = [pkgs.docker];
      #   serviceConfig = {
      #     Type = "oneshot";
      #     RemainAfterExit = true;
      #   };
      #   script = ''
      #     docker volume inspect dawarich_dawarich_redis_data || docker volume create dawarich_dawarich_redis_data
      #   '';
      #   partOf = ["docker-compose-dawarich-root.target"];
      #   wantedBy = ["docker-compose-dawarich-root.target"];
      # };
      "docker-volume-dawarich_dawarich_storage" = {
        path = [pkgs.docker];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          docker volume inspect dawarich_dawarich_storage || docker volume create dawarich_dawarich_storage
        '';
        partOf = ["docker-compose-dawarich-root.target"];
        wantedBy = ["docker-compose-dawarich-root.target"];
      };
      "docker-volume-dawarich_dawarich_watched" = {
        path = [pkgs.docker];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };
        script = ''
          docker volume inspect dawarich_dawarich_watched || docker volume create dawarich_dawarich_watched
        '';
        partOf = ["docker-compose-dawarich-root.target"];
        wantedBy = ["docker-compose-dawarich-root.target"];
      };
    };

    # Root service
    # When started, this will automatically create all resources and start
    # the containers. When stopped, this will teardown all resources.
    targets."docker-compose-dawarich-root" = {
      unitConfig = {
        Description = "Root target generated by compose2nix.";
      };
      wantedBy = ["multi-user.target"];
    };
  };
}
