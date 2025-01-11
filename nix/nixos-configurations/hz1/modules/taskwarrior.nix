{config, ...}: {
  services.taskchampion-sync-server = {
    enable = true;
  };

  services.caddy.virtualHosts."tw.pltanton.dev".extraConfig = ''
    reverse_proxy http://localhost:${toString config.services.taskchampion-sync-server.port}
  '';

  services.ccsync = {
    enable = false;
  };
}
