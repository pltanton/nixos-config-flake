{inputs, ...}: {
  system = "x86_64-linux";

  specialArgs = {
    stateVersion = "25.11";
  };

  modules = with inputs; [
    self.nixosModules.desktop

    ./hardware-configuration.nix
    ./hardware-configuration-custom.nix

    (import ./modules)
  ];
}
