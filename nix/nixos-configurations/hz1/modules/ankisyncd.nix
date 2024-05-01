{ pkgs, config, sops, ... }: {
  sops.secrets."anki/anton" = {};
  sops.secrets."anki/julsa" = {};
  services.anki-sync-server = {
    enable = true;
    users = [
      {
        username = "anton";
        passwordFile = config.sops.secrets."anki/anton".path;
      }
      {
        username = "julsa";
        passwordFile = config.sops.secrets."anki/julsa".path;
      }
    ];
  };

  services.caddy.virtualHosts."anki.kaliwe.ru".extraConfig = ''
    reverse_proxy [::1]:${toString config.services.anki-sync-server.port}
  '';
}
