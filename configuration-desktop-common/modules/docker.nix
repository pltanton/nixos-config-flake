{ pkgs, lib, config, ... }: {
  virtualisation = {
    docker.enable = true;
    docker.daemon.settings = { dns = [ "8.8.8.8" "1.1.1.1" ]; };

    oci-containers.backend = "docker";

    podman = {
      enable = false;
      dockerCompat = true;
    };
  };

  environment.systemPackages = [
    (lib.mkIf config.virtualisation.docker.enable pkgs.docker-compose)
    (lib.mkIf config.virtualisation.podman.enable pkgs.podman-compose)
  ];
}
