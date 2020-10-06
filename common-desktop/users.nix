{ pkgs, ... }: {
  home-manager.useGlobalPkgs = true;

  users = {
    users = {
      julsa = {
        isNormalUser = true;
        shell = pkgs.fish;
        home = "/home/julsa";
        extraGroups =
          [ "wheel" "networkmanager" "audio" "video" "docker" "lp" "scanner" ];
      };
    };
  };
}
