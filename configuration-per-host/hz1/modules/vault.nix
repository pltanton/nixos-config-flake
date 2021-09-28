{ config, pkgs, ... }:

let
  host = "vault.kaliwe.ru";
  port = "8200";
  certBase = "${config.security.acme.directory}/${host}";
in {
  services = {
    vault = {
      enable = true;
      address = "127.0.0.1:${port}";
      storageBackend = "postgresql";
      storageConfig = "connection_url=\"postgresql://vault:vault@localhost:5432/vault?sslmode=disable\"";
      package = pkgs.vault-bin;
      extraConfig = ''
        ui = true
      '';
#      package = ((import (pkgs.fetchFromGitHub {
#        owner = "obfusk";
#        repo = "nix-vault-with-ui";
#        rev = "664d3d9a1f30626d0277a62c520cf82df0e0a2a1";
#        sha256 = "029ihpmzm1y49pb03lvg4sb4jlirmw73gfbpdv1657wazrb6rs6s";
#      })) { pkgs = pkgs; }).vault-with-ui;
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts."${host}" = {
      enableACME = true;
      forceSSL = true;

      locations."/".proxyPass = "http://127.0.0.1:${port}";
    };
  };
}

