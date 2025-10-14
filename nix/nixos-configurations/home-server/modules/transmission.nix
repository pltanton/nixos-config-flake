{
  config,
  lib,
  ...
}: let
  consts = import ../constants.nix;
  downloadsDir = "${consts.publicMedia}/downloads";
in {
  sops.secrets.transmission-rpc-password = {};

  systemd.tmpfiles.rules = lib.mkIf config.services.transmission.enable [
    "d ${consts.publicMedia}/downloads 0775 publicstore publicstore"
    "d ${consts.publicMedia}/downloads/tvshows 0775 publicstore publicstore"
    "d ${consts.publicMedia}/downloads/movies 0775 publicstore publicstore"
  ];
  services.transmission = {
    enable = true;
    group = "publicstore";
    credentialsFile = config.sops.secrets.transmission-rpc-password.path;
    downloadDirPermissions = "775";

    settings = {
      download-dir = downloadsDir;
      incomplete-dir-enabled = false;
      rpc-username = "admin";
      rpc-authentication-required = "true";
      rpc-host-whitelist-enabled = false;
      umask = 2;
    };
  };

  services.caddy.virtualHosts."torrent.kaliwe.ru".extraConfig = ''
    reverse_proxy http://127.0.0.1:9091
  '';

  users.users.transmission.extraGroups = ["publicstore"];
}
