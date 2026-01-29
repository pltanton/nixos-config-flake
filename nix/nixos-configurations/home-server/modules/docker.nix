_: {
  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
      daemon.settings = {dns = ["8.8.8.8" "1.1.1.1"];};
    };
  };
}
