{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.self.darwinModules.common
  ];

  programs.fish.enable = true;
  system.stateVersion = 4;
  nix = {
    enable = false;
  };

  system.primaryUser = "anton";
  users.users.anton = {
    shell = pkgs.fish;
    name = "anton";
    home = "/Users/anton";
  };
}
