{ pkgs, ... }: {
  home-manager.users.anton = import ../../../home/anton/home.nix;

  users = {
    users = {
      anton = {
        isNormalUser = true;
        shell = pkgs.zsh;
        home = "/home/anton";
        extraGroups = [
          "adbusers"
          "wheel"
          "networkmanager"
          "audio"
          "docker"
          "lp"
          "scanner"
          "vboxusers"
        ];
      };

      julsa = {
        isNormalUser = true;
        shell = pkgs.zsh;
        home = "/home/julsa";
        extraGroups = [ "wheel" "networkmanager" "audio" "docker" ];
      };
    };
  };
}
