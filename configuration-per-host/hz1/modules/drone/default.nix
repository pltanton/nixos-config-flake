{ pkgs, config, ... }:

{
  #   # imports = [ ./server.nix ./exec-runner.nix ./docker-runner.nix ];

  #   # environment.systemPackages = [ pkgs.drone-cli ];
  #   services.drone = {
  #     enable = true;
  #     runners = [ "exec" "docker" ];
  #     admin = "pltanton";
  #     secretFile = "/run/secrets/drone-gitea.env";
  #     secretSharedFile = "/run/secrets/drone-rpc.env";
  #   };
}
