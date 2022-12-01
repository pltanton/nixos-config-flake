{ nixpkgs, lib, config, ... }: {
  services.gotify.enable = false;
  services.gotify.port = 3031;

  services.nginx = {
    enable = true;
    virtualHosts."gotify.kaliwe.ru" = lib.mkIf (config.services.gotify.enable) {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyWebsockets = true;
        proxyPass = "http://127.0.0.1:3031";
      };
    };
  };

  security.acme.certs = lib.mkIf (config.services.gotify.enable) {
    "gotify.kaliwe.ru".email = "plotnikovanton@gmail.com";
  };
}
