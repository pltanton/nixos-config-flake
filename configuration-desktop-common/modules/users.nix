{ pkgs, ... }: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  nix.settings.trusted-users = [ "root" "@wheel" ];

  programs.fish = {
    shellInit = ''
      set fish_greeting
    '';
  };

  users = {
    users = {
      anton = {
        openssh.authorizedKeys = {
          keys = [
            "sk-ecdsa-sha2-nistp256@openssh.com AAAAInNrLWVjZHNhLXNoYTItbmlzdHAyNTZAb3BlbnNzaC5jb20AAAAIbmlzdHAyNTYAAABBBPTAlFRwD3rXUYqCUBSZFpBLJYP9dXSV4gWxSP/dAdPjuYQHZxghMigubprVhoHLrUD/4w7BgB8QR356qGHeNTUAAAAEc3NoOg== anton@nixos"
          ];
        };

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
          "kvm"
          "input"
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
