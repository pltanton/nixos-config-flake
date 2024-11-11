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
      features = {
        buildkit = true;
      };
      # Fix for route conflicts with VPNs, which typically operate in the
      # 172.16.0.0/12 space.
      bip = "192.168.253.0/23";
      default-address-pools = [{
        base = "192.168.254.0/23";
        size = 27;
      }];
    };
  };

  environment.systemPackages = [
    (lib.mkIf config.virtualisation.docker.enable pkgs.docker-compose)
    (lib.mkIf config.virtualisation.podman.enable pkgs.podman-compose)
  ];
}
