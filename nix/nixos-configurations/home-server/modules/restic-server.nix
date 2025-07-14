{
  config,
  consts,
  ...
}: {
  sops.secrets."restic-htpasswd".owner = "restic";

  services.restic.server = {
    enable = true;
    listenAddress = "127.0.0.1:8001";
    htpasswd-file = config.sops.secrets."restic-htpasswd".path;
    dataDir = "${consts.archive}/restic";
  };

  services.caddy.virtualHosts."restic-home.pltanton.dev".extraConfig = ''
    handle {
      reverse_proxy http://127.0.0.1:8001
    }
  '';
}
