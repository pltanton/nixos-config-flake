{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.self.darwinModules.common
  ];

  system.stateVersion = 4;
}
