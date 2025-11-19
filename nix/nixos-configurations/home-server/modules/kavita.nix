{config, ...}: {
  sops.secrets."kavita-token" = {};

  users.users.kavita.extraGroups = ["publicstore"];

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
