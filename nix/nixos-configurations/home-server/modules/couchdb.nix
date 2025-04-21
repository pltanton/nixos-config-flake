{config, ...}: {
  sops.secrets."couchdb-config".owner = config.services.couchdb.user;
  services = {
    couchdb = {
      enable = true;
      extraConfig = {
        couchdb.max_document_size = "50000000";
        chttpd_auth.require_valid_user = "true";
        chttpd = {
          require_valid_user = "true";
          max_http_request_size = 4294967296;
        };
        cors = {
          origins = "app://obsidian.md,capacitor://localhost,http://localhost";
          credentials = "true";
        };
        httpd = {
          enable_cors = "true";
          "WWW-Authenticate" = "Basic realm=\"couchdb\"";
        };
      };
      extraConfigFiles = [
        config.sops.secrets."couchdb-config".path # For admin user password
      ];
    };

    caddy.virtualHosts."couchdb.pltanton.dev".extraConfig = ''
      reverse_proxy http://127.0.0.1:${toString config.services.couchdb.port}
    '';
  };
}
