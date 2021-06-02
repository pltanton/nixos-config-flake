{ nixpkgs, ... }: {
  services.gotify.enable = true;
  services.gotify.port = 3031;

  services.nginx = {
    enable = true;
    virtualHosts."gotify.kaliwe.ru" = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://127.0.0.1:3031";
      };
    };
  };

  security.acme.certs = {
    "gitea.kaliwe.ru".email = "plotnikovanton@gmail.com";
  };
}
