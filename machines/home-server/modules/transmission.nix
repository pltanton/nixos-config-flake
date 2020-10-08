{ config, pkgs, ... }:

let
  consts = import ../constants.nix;
  secrets = import ../secrets.nix;
  transmissionHome = "${consts.mediaAppHomes}";
  delugeHome = "${consts.mediaAppHomes}/deluge-home";
  downloadsDir = "${consts.publicMedia}/downloads";
in {
  services = {
    transmission = {
      enable = false;
      group = "publicstore";
      user = "publicstore";
      home = "${transmissionHome}/transmission-home";

      settings = {
        download-dir = downloadsDir;
        rpc-username = "admin";
        rpc-password = secrets.transmissionRpcPassword;
        rpc-authentication-required = "true";
      };
    };

    deluge = {
      enable = true;
      dataDir = delugeHome;
      group = "publicstore";
      user = "publicstore";
      web.enable = true;
    };

    nginx = {
      virtualHosts."torrent.kaliwe.ru" = {
        enableACME = true;
        forceSSL = true;
        locations."/".proxyPass = "http://localhost:8112";
      };
    };
  };

  security.acme.certs = {
    "torrent.kaliwe.ru".email = "plotnikovanton@gmail.com";
  };
}
