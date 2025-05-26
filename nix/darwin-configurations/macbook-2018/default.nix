{
  system = "x86_64-darwin";

  modules = [
    ./configuration.nix
    # self.inputs.home-manager.nixosModules.home-manager
    # {
    #   home-manager.useGlobalPkgs = true;
    #   home-manager.useUserPackages = true;
    # }
  ];
}
