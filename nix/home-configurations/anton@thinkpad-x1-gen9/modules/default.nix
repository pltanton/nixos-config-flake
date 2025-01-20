{inputs, ...}: {
  # imports = inputs.self.lib.modulesDir ./.;
  imports = [
    ./hyprland
    ./kanshi.nix
    ./plain-packages.nix
  ];
}
