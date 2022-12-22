{ pkgs, lib, config, ... }: {
  virtualisation = {
    docker.enable = true;

    oci-containers.backend = "docker";

    podman = {
      enable = false;
      dockerCompat = false;
      defaultNetwork.dnsname.enable = true;
    };
  };

  environment.systemPackages =
    lib.mkIf (config.virtualisation.docker.enable) [ pkgs.docker-compose ];

}
