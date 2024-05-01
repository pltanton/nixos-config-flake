{inputs, ...}: 
{
  system = "x86_64-linux";

  specialArgs = {
    inherit inputs;
    stateVersion = "21.11";
  };

  modules = with inputs;[
    self.nixosModules.common

    ./configuration.nix

    (import ./modules)
  ];
}