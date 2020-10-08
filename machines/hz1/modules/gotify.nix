{nixpkgs, ...}: {
  services.gotify.enable = true;
  services.gotify.port = 3030;

  services.nginx = {
    enable = true;
    virtualHosts."gotify.kaliwe.ru" = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://127.0.0.1:3030";
      };
    };
  };

  security.acme.certs = {
    "gitea.kaliwe.ru".email = "plotnikovanton@gmail.com";
  };
}
