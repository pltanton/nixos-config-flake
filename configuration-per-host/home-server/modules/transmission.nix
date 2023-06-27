{ config, pkgs, lib, ... }:

let
  consts = import ../constants.nix;
  secrets = import ../secrets.nix;
  # transmissionHome = "${consts.mediaAppHomes}";
  downloadsDir = "${consts.publicMedia}/downloads";
in {
  systemd.tmpfiles.rules = lib.mkIf config.services.transmission.enable [
    "d ${consts.publicMedia}/downloads 0775 publicstore publicstore"
    "d ${consts.publicMedia}/downloads/tvshows 0775 publicstore publicstore"
    "d ${consts.publicMedia}/downloads/movies 0775 publicstore publicstore"
  ];
  services = {
    transmission = {
      enable = true;
      group = "publicstore";
      # user = "publicstore";
      # home = "${transmissionHome}/transmission-home";

      settings = {
        download-dir = downloadsDir;
        incomplete-dir-enabled = false;
        rpc-username = "admin";
        rpc-password = secrets.transmissionRpcPassword;
        rpc-authentication-required = "true";
      };
    };

    nginx = {
      virtualHosts."torrent.kaliwe.ru" = {
        enableACME = true;
        forceSSL = true;
        locations."/".proxyPass = "http://localhost:9091";
      };
    };
  };

  security.acme.certs = {
    "torrent.kaliwe.ru".email = "plotnikovanton@gmail.com";
  };

  users.users.transmission.extraGroups = [ "publicstore" ];
}
