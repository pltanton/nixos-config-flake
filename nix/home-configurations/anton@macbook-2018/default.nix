{inputs, ...}: {
  system = "x86_64-darwin";

  sops = {
    defaultSopsFile = ../secrets.yaml;
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
  };

  modules = [
    inputs.self.homeModules.anton
    inputs.self.homeModules.anton-mac

    {
      home.stateVersion = "25.05";
      home.homeDirectory = "/Users/anton";

      nixpkgs.config.allowUnfree = true;
    }
  ];
}
