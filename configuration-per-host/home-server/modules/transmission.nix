{ config, pkgs, ... }:

let
  consts = import ../constants.nix;
  secrets = import ../secrets.nix;
  transmissionHome = "${consts.mediaAppHomes}";
  downloadsDir = "${consts.publicMedia}/downloads";
in {
  services = {
    transmission = {
      enable = true;
      group = "publicstore";
      # user = "publicstore";
      home = "${transmissionHome}/transmission-home";

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
