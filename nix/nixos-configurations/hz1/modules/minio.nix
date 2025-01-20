_: {
  services.minio = {
    enable = true;
    listenAddress = ":9200";
    consoleAddress = ":9201";
  };

  systemd.services.minio.environment = {
    MINIO_BROWSER_REDIRECT_URL = "https://s3.kaliwe.ru/console/";
    MINIO_SERVER_URL = "https://s3.kaliwe.ru";
  };

  services.caddy.virtualHosts."s3.kaliwe.ru".extraConfig = ''
      handle_path /console/* {
        reverse_proxy http://127.0.0.1:9201
      }

      handle {
        reverse_proxy http://127.0.0.1:9200
      }
    # '';
}
