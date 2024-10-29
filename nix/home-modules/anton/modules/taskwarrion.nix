{pkgs, ...}: {
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
  };

  services.taskwarrior-sync = {
    enable = true;
    package = pkgs.taskwarrior3;
  };

  nixpkgs.config.allowBroken = true;
  home.packages = [
    pkgs.syncall
  ];
}