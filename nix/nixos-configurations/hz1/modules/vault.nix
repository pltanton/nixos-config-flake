{
  config,
  pkgs,
  ...
}: let
  host = "vault.kaliwe.ru";
  port = "8200";
in {
  services = {
    vault = {
      enable = false;
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
