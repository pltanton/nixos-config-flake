{ pkgs, ... }: {
  virtualisation = {
    docker.enable = true;

    podman = {
      enable = false;
      dockerCompat = true;
    };
  };
}
