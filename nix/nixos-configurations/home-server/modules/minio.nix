{config, ...}: {
  sops.secrets."minio-root-password" = {};

  services.minio = {
    enable = true;
    listenAddress = ":9200";
    consoleAddress = ":9201";
    rootCredentialsFile = config.sops.secrets."minio-root-password".path;
  };

  systemd.services.minio.environment = {
    MINIO_BROWSER_REDIRECT_URL = "https://s3-home.pltanton.dev/console/";
    MINIO_SERVER_URL = "https://s3-home.pltanton.dev";
  };

  services.caddy.virtualHosts."s3-home.pltanton.dev".extraConfig = ''
    handle_path /console/* {
      reverse_proxy http://127.0.0.1:9201
    }

    handle {
      reverse_proxy http://127.0.0.1:9200
    }
  '';
}
