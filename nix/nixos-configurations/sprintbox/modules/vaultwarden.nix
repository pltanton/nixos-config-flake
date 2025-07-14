_: {
  services = {
    vaultwarden = {
      enable = true;
      dbBackend = "postgresql";
      config = {
        domain = "https://bitwarden.kaliwe.ru";
        signupsAllowed = true;
        databaseUrl = "postgresql://vaultwarden@localhost/vaultwarden";
        rocketPort = 8222;
      };
      environmentFile = "/root/vaultvarden.env";
    };
  };

  services.caddy = {
    virtualHosts."bitwarden.kaliwe.ru".extraConfig = ''
      reverse_proxy http://127.0.0.1:8222
    '';
  };
}
