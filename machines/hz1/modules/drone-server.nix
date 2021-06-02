{ pkgs, config, ... }:

{
  my.services.drone = {
    enable = true;
    runners = [ "exec" "docker" ];
    admin = "pltanton";
    port = 3030;
    host = "drone.kaliwe.ru";
    secretFile = "/root/drone-gitea.env";
    sharedSecretFile = "/root/drone-rpc.env";
  };
}
