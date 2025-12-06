{inputs, ...}: {
  system = "aarch64-darwin";

  modules = [
    inputs.self.homeModules.anton
    inputs.self.homeModules.anton-mac

    {
      home.stateVersion = "25.05";
      home.homeDirectory = "/Users/anton";

      nixpkgs.config.allowUnfree = true;
    }

    (import ./syncthing.nix)
  ];
}
