{ pkgs, ... }: {
  virtualisation = {
    docker.enable = true;

    podman = {
      enable = false;
      dockerCompat = true;
    };

    #virtualbox.host.enable = true;
    #virtualbox.host.enableExtensionPack = true;
  };
}
