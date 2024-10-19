{
  pkgs,
  lib,
  config,
  ...
}: {
  virtualisation = {
    docker.enable = true;

    oci-containers.backend = "docker";

    podman = {
      enable = false;
      dockerCompat = true;
    };

    docker.daemon.settings = {
      dns = ["8.8.8.8" "1.1.1.1"];
      "default-address-pools" = [
        {
          "base" = "172.27.0.0/16";
          "size" = 24;
        }
      ];
    };
  };

  environment.systemPackages = [
    (lib.mkIf config.virtualisation.docker.enable pkgs.docker-compose)
    (lib.mkIf config.virtualisation.podman.enable pkgs.podman-compose)
  ];
}
