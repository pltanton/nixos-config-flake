{inputs, ...}: {
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
    name = "anton";
    home = "/Users/anton";
  };
}
