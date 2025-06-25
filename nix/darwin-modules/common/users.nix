{pkgs, ...}: {
  nix = {
    enable = false;
  };

  programs.fish.enable = true;

  system.primaryUser = "anton";
  users.users.anton = {
    shell = pkgs.fish;
    name = "anton";
    home = "/Users/anton";
  };
}
