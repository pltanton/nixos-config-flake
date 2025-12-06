{inputs, ...}: {
  imports = [
    inputs.self.darwinModules.kanata
    ./homebrew.nix
    ./users.nix
    ./kanata
  ];
}
