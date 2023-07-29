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
      storageConfig = ''
        connection_url="postgresql://vault:vault@localhost:5432/vault?sslmode=disable"'';
      package = pkgs.vault-bin;
      extraConfig = ''
        ui = true
      '';
    };
  };

  services.caddy.virtualHosts."${host}".extraConfig = ''
    reverse_proxy http://127.0.0.1:${port}
  '';
}
