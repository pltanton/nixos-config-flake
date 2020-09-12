{ config, pkgs, ... }:

{
  docker-containers.drone = {
    image = "drone/drone:1.1";
    ports = [
      "3011:80"
    ];
    volumes = [
      "/root/drone:/data"
      "/var/run/docker.sock:/var/run/docker.sock"
    ];
    environment = {
      DRONE_GITEA_SERVER = "https://gitea.kaliwe.ru";
      DRONE_GIT_ALWAYS_AUTH = "false";
      DRONE_SERVER_HOST = "drone.kaliwe.ru";
      DRONE_SERVER_PROTO = "https";
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts."drone.kaliwe.ru" = {
      enableACME = true;
      forceSSL = true;

      locations."/".proxyPass = "http://127.0.0.1:3011";
    };
  };

  security.acme.certs = {
    "drone.kaliwe.ru".email = "plotnikovanton@gmail.com";
  };
}
