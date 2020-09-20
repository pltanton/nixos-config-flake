{ config, pkgs, ... }:

let
  consts = import ../constants.nix;
  secrets = import ../secrets.nix;
  transmissionHome = "${consts.mediaAppHomes}/transmission-home";
in {
  services = {
    transmission = {
      enable = true;
      group = "publicstore";
      user = "publicstore";
      home = "${transmissionHome}/transmission-home";

      settings = {
        download-dir = "${transmissionHome}/complete/";
        incomplete-dir = "${transmissionHome}/incomplete/";
        incomplete-dir-enabled = true;

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
}
