{
  config,
  pkgs,
  ...
}: {
  services = {
    vaultwarden = {
      enable = true;
      dbBackend = "postgresql";
      config = {
        domain = "https://bitwarden-de.kaliwe.ru";
        signupsAllowed = true;
        databaseUrl = "postgresql://bitwarden:bitwarden@localhost/bitwarden";
        #enableDbWal = false;
        #extendedLogging = true;
        rocketPort = 8222;
      };
    };
  };

  services.caddy.virtualHosts."bitwarden-de.kaliwe.ru".extraConfig = ''
    reverse_proxy http://127.0.0.1:8222
  '';
}
