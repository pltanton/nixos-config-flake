_: {
  virtualisation = {
    docker.enable = true;
    docker.autoPrune.enable = true;
    docker.daemon.settings = {dns = ["8.8.8.8" "1.1.1.1"];};
  };
}
