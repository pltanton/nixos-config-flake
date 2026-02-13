{inputs, ...}: {
  system = "aarch64-darwin";

  modules = [
    inputs.self.homeModules.anton
    inputs.self.homeModules.anton-mac

    ({config, ...}: {
      sops = {
        defaultSopsFile = ../../nixos-modules/sops/anton.yaml;
        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      };
    })

    {
      home.stateVersion = "25.05";
      home.homeDirectory = "/Users/anton";

      nixpkgs.config.allowUnfree = true;
    }

    (import ./syncthing.nix)
  ];
}
