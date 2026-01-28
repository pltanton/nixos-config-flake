{inputs, ...}: {
  system = "x86_64-linux";

  modules = [
    inputs.self.homeModules.anton
    inputs.self.homeModules.anton-linux

    {
      home.stateVersion = "25.11";
      nixpkgs.config.allowUnfree = true;
    }

    (import ./modules)
  ];
}
