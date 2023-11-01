{ config, pkgs, ... }:

let
  secrets = import ../secrets.nix;
  consts = import ../constants.nix;
  nextcloudHome = "${consts.archiveMountPoint}/nextcloud-home";
  nextcloudPackage = pkgs.nextcloud27;

  archiveDst = "${nextcloudHome}/data/anton/files/Archive";

  photoSrc = "${consts.archiveMountPoint}/archive/photo";
  photoRawSrc = "${consts.archiveMountPoint}/archive/photo_raw";

  photoDst = "${archiveDst}/photo";
  photoRawDst = "${archiveDst}/photo_raw";
in {
  systemd = {
    timers.simple-timer = {
      wantedBy = [ "timers.target" ];
      partOf = [ "nextcloud-facerecognition.service" ];
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

      enableBrokenCiphersForSSE = false;
      phpExtraExtensions = all: with all; [ pdlib bz2 ];
      caching = {
        apcu = true;
        redis = false;
        memcached = false;
      };
      autoUpdateApps.enable = true;
      package = nextcloudPackage;
      config = {
        # adminpass = "adminpass";
        adminpassFile = "/media/archive/nextcloud-home/adminpass";
        dbtype = "pgsql";
      };
      home = "/media/archive/nextcloud-home";
      hostName = "nextcloud.kaliwe.ru";
      # https = true;
      phpOptions = {
        short_open_tag = "Off";
        expose_php = "Off";
        error_reporting = "E_ALL & ~E_DEPRECATED & ~E_STRICT";
        display_errors = "stderr";
        "opcache.enbale" = "1";
        "opcache.enable_cli" = "1";
        "opcache.interned_strings_buffer" = "8";
        "opcache.max_accelerated_files" = "10000";
        "opcache.memory_consumption" = "128";
        "opcache.revalidate_freq" = "1";
        "opcache.fast_shutdown" = "1";
        "openssl.cafile" = "/etc/ssl/certs/ca-certificates.crt";
        catch_workers_output = "yes";
        # memory_limit = "5120M";
        default_phone_region = "RU";
      };
    };

    # Proxy for Nextloud Talk
    coturn = {
      enable = true;
      use-auth-secret = true;
      static-auth-secret = secrets.turnSecret;
      realm = "turn.kaliwe.ru";
      extraConfig = ''
        total-quota=100
        bps-capacity=0
        stale-nonce
        no-multicast-peers
        fingerprint
      '';
    };
  };

  users.users.nextcloud.extraGroups = [ "lp" "privatestore" ];

  environment.systemPackages = with pkgs; [ dlib netpbm nodejs ];

  fileSystems = {
    "${photoDst}" = {
      device = photoSrc;
      options = [ "bind" ];
    };

    "${photoRawDst}" = {
      device = photoRawSrc;
      options = [ "bind" ];
    };
  };

  services.phpfpm.pools.nextcloud.settings = {
    "listen.owner" = config.services.caddy.user;
    "listen.group" = config.services.caddy.group;
  };

  users.groups.nextcloud.members = [ "nextcloud" config.services.caddy.user ];

  services.caddy.virtualHosts."nextcloud.kaliwe.ru".extraConfig = ''
    root * ${config.services.nextcloud.package}
    root /store-apps/* ${config.services.nextcloud.home}  # <<< these two lines
    root /nix-apps/* ${config.services.nextcloud.home}    # <<< these two lines
    encode zstd gzip

    php_fastcgi unix//${config.services.phpfpm.pools.nextcloud.socket}
    file_server

    header {
      Strict-Transport-Security max-age=31536000;
    }

    redir /.well-known/carddav /remote.php/dav 301
    redir /.well-known/caldav /remote.php/dav 301
  '';
}
