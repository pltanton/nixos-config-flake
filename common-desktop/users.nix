{ pkgs, ... }: {
  home-manager.useGlobalPkgs = true;

  users = {
    users = {
      anton = {
        isNormalUser = true;
        shell = pkgs.fish;
        home = "/home/anton";
        extraGroups = [
          "adbusers"
          "wheel"
          "networkmanager"
          "audio"
          "video"
          "docker"
          "lp"
          "scanner"
          "vboxusers"
        ];
      };

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
