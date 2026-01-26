{config, ...}: {
  sops.secrets."karakeep-env" = {};

  services.karakeep = {
    enable = true;
    meilisearch.enable = true;
    environmentFile = config.sops.secrets."karakeep-env".path;
    extraEnvironment = {
      DISABLE_NEW_RELEASE_CHECK = "true";
    };
  };

  services.caddy.virtualHosts."karakeep.pltanton.dev".extraConfig = ''
    reverse_proxy http://127.0.0.1:3000
  '';
}
