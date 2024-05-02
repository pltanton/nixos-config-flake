{
  config,
  lib,
  pkgs,
  ...
}: {
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
        WOODPECKER_MAX_WORKFLOWS = "4";
        WOODPECKER_AGENT_SECRET = "KOKOJ2JICI6SPXZ5AQRNAX4SYGVZ7OZIQ5GUQSEB6H4JPGFTYK5Q====";
      };
      extraGroups = ["docker"];
    };
  };
}
