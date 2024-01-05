{ pkgs, config, ... }: {

  sops.secrets."photoprism" = { };

  services.photoprism = {
    enable = true;
    storagePath = "/media/archive/photoprism";
    passwordFile = "/var/secrets/photoprism";
  };

  services.caddy.virtualHosts."photoprism.kaliwe.ru".extraConfig = ''
    reverse_proxy http://localhost:${config.services.photoprism.port}
  '';
}