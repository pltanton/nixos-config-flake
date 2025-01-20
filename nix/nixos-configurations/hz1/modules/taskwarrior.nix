{config, ...}: {
  services = {
    taskchampion-sync-server = {
      enable = true;
    };

    caddy.virtualHosts."tw.pltanton.dev".extraConfig = ''
      reverse_proxy http://localhost:${toString config.services.taskchampion-sync-server.port}
    '';
  };
}
