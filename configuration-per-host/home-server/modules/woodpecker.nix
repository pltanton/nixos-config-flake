{ config, lib, pkgs, ... }:

{
  services.woodpecker-agents.agents = {
    docker = {
      enable = true;
      package = pkgs.unstable.woodpecker-agent;

      environment = {
        # DOCKER_HOST = "unix:///run/podman/podman.sock";
        WOODPECKER_LOG_LEVEL = "debug";
        WOODPECKER_BACKEND = "docker";
        WOODPECKER_SERVER = "hz1.kaliwe.ru:9000";
        WOODPECKER_HOSTNAME = "ci.kaliwe.ru";
        WOODPECKER_AGENT_SECRET =
          "d03db2f4cc46104075afc8261633e9dee26df3b701009e49b4800f35df5a2e36";
      };
      extraGroups = [ "docker" ];
    };
  };
}
