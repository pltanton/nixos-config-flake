{
  config,
  pkgs,
  lib,
  ...
}: let
  consts = import ../constants.nix;

  nextcloudData = "${consts.archiveMountPoint}/nextcloud-data";
  photoSrc = "${consts.archiveMountPoint}/archive/photo";
  photoRawSrc = "${consts.archiveMountPoint}/archive/photo_raw";
in {
  fileSystems = {
    "${config.services.nextcloud.home}/data" = {
      device = nextcloudData;
      options = ["bind"];
    };

    "${config.services.nextcloud.home}/data/anton/files/Archive/photo_raw" = {
      device = photoRawSrc;
      options = ["bind" "ro"];
    };

    "${config.services.nextcloud.home}/data/anton/files/Archive/photo" = {
      device = photoSrc;
      options = ["bind" "ro"];
    };
  };

  systemd = {
    timers.simple-timer = {
      wantedBy = ["timers.target"];
      partOf = ["nextcloud-facerecognition.service"];
      timerConfig.OnCalendar = "hourly";
    };
    services.nextcloud-facerecognition = {
      serviceConfig.Type = "oneshot";
      script = ''
        /run/current-system/sw/bin/nextcloud-occ face:background_job
      '';
    };
  };

  services = {
    nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;

      phpExtraExtensions = all: with all; [pdlib bz2];

      caching = {
        apcu = true;
        redis = false;
        memcached = false;
      };
      autoUpdateApps.enable = true;
      config = {
        # adminpass = "adminpass";
        adminpassFile = "/media/archive/nextcloud-home/adminpass";
        dbtype = "pgsql";
      };
      # home = "/media/archive/nextcloud-home";
      hostName = "nextcloud.kaliwe.ru";
      # https = true;

      extraOptions = {
        "memories.exiftool" = "${lib.getExe pkgs.exiftool}";
        "memories.exiftool_no_local" = true;
        "memories.vod.ffmpeg" = "${pkgs.ffmpeg-headless}/bin/ffmpeg";
        "memories.vod.ffprobe" = "${pkgs.ffmpeg-headless}/bin/ffprobe";
        "default_language" = "en";
      };
    };

    phpfpm.pools.nextcloud.settings = {
      "listen.owner" = config.services.caddy.user;
      "listen.group" = config.services.caddy.group;
    };

    caddy.virtualHosts."nextcloud.kaliwe.ru".extraConfig = ''
      root * ${config.services.nextcloud.package}
      root /store-apps/* ${config.services.nextcloud.home}
      root /nix-apps/* ${config.services.nextcloud.home}
      encode zstd gzip

      php_fastcgi unix//${config.services.phpfpm.pools.nextcloud.socket}
      file_server

      header {
        Strict-Transport-Security max-age=31536000;
      }

      redir /.well-known/carddav /remote.php/dav 301
      redir /.well-known/caldav /remote.php/dav 301
    '';
  };

  systemd.services.nextcloud-cron.path = [pkgs.perl];

  users = {
    users.nextcloud = {
      uid = 1002;
      extraGroups = ["lp" "privatestore"];
    };
    groups = {
      nextcloud.members = ["nextcloud" config.services.caddy.user];
      privatestore.members = [config.services.caddy.user];
    };
  };

  environment.systemPackages = with pkgs; [dlib netpbm nodejs];
}
