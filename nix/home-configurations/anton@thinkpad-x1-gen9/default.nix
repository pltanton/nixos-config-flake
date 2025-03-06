{inputs, ...}: {
  system = "x86_64-linux";

  modules = [
    inputs.self.homeModules.anton

    {
      home.stateVersion = "22.05";
      nixpkgs.config.allowUnfree = true;
    }

    (import ./modules)
  ];
}
