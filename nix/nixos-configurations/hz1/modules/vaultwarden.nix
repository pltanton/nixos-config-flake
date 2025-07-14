{config, ...}: {
  sops.secrets."vaultwarden-env".owner = "vaultwarden";

  services = {
    vaultwarden = {
      enable = true;
      dbBackend = "postgresql";
      config = {
        domain = "https://vaultwarden.pltanton.dev";
        signupsAllowed = true;
        databaseUrl = "postgresql://vaultwarden@/vaultwarden";
        rocketPort = 8222;
      };
      environmentFile = config.sops.secrets."vaultwarden-env".path;
    };
  };

  services.caddy = {
    virtualHosts."vaultwarden.pltanton.dev".extraConfig = ''
      reverse_proxy http://127.0.0.1:8222
    '';
  };
}
