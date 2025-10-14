{config, ...}: {
  sops.secrets."kavita-token" = {};

  services = {
    kavita = {
      enable = true;
      tokenKeyFile = config.sops.secrets."kavita-token".path;
    };


    caddy.virtualHosts."kavita.pltanton.dev".extraConfig = ''
      reverse_proxy http://127.0.0.1:${toString config.services.kavita.settings.Port}
    '';
  };

}
