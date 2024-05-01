{ inputs, ... }:
{
  system = "x86_64-linux";

  specialArgs = {
    inherit inputs;
    stateVersion = "22.05";
  };

  # imports = (builtins.map
  #   (name: ./modules + "/${name}")
  #   (builtins.attrNames (builtins.readDir ./modules))
  # );

  modules = with inputs;[
    self.nixosModules.common

    ./hardware-configuration.nix
    ./hardware-configuration-custom.nix
  ];
}
