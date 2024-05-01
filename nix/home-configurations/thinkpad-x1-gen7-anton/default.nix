{ inputs, lib, ... }:

{
  system = "x86_64-linux";

  modules = with inputs;[
    self.homeModules.anton

    {
      home.stateVersion = "22.05";
      nixpkgs.config.allowUnfree = true;
    }

    (import ./modules)
  ];
}
