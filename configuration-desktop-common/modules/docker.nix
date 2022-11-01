{ pkgs, ... }: {
  virtualisation = {
    docker.enable = false;

    oci-containers.backend = "podman";

    podman = {
      enable = true;
      dockerCompat = false;
      defaultNetwork.dnsname.enable = true;
    };
  };
}
