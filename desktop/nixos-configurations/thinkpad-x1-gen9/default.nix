{ inputs, ... }:
{
  system = "x86_64-linux";

  specialArgs = {
    inherit inputs;
    stateVersion = "22.05";
  };

  modules = with inputs;[
    self.nixosModules.desktop

    ./hardware-configuration.nix
    ./hardware-configuration-custom.nix
  ] ++ inputs.self.lib.modulesDir ./modules;
}
