{ config, pkgs, ... }:

let
  secrets = import ../secrets.nix;
  consts = import ../constants.nix;
  nextcloudHome = "${consts.archiveMountPoint}/nextcloud-home";
  nextcloudPackage = pkgs.nextcloud22;

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
      phpExtraExtensions = all: with all; [ pdlib bz2 ];
      caching = {
        apcu = false;
        redis = true;
        memcached = false;
      };
      autoUpdateApps.enable = true;
      package = nextcloudPackage;
      enable = true;
      config = {
        adminpass = "adminpass";
        dbtype = "pgsql";
      };
      home = "/media/archive/nextcloud-home";
      hostName = "nextcloud.kaliwe.ru";
      https = true;
      phpOptions = {
        short_open_tag = "Off";
        expose_php = "Off";
        error_reporting = "E_ALL & ~E_DEPRECATED & ~E_STRICT";
        display_errors = "stderr";
        "opcache.enable_cli" = "1";
        "opcache.interned_strings_buffer" = "8";
        "opcache.max_accelerated_files" = "10000";
        "opcache.memory_consumption" = "128";
        "opcache.revalidate_freq" = "1";
        "opcache.fast_shutdown" = "1";
        "openssl.cafile" = "/etc/ssl/certs/ca-certificates.crt";
        catch_workers_output = "yes";
        memory_limit = "5120M";
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

    nginx = {
      virtualHosts."nextcloud.kaliwe.ru" = {
        enableACME = true;
        forceSSL = true;
      };
    };
  };

  security.acme.certs = {
    "nextcloud.kaliwe.ru".email = "plotnikovanton@gmail.com";
  };

  users.users.nextcloud.extraGroups = [ "lp" "privatestore" ];
  users.users.nginx.extraGroups = [ "lp" ];

  environment.systemPackages = with pkgs; [ dlib netpbm ];

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
}
