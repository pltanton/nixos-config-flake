{ pkgs, ... }: {
  virtualisation = {
    docker.enable = false;

    podman = {
      enable = true;
      dockerCompat = true;
    };

    #virtualbox.host.enable = true;
    #virtualbox.host.enableExtensionPack = true;
  };
}
