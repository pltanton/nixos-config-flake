{inputs, ...}: {
  imports = with inputs;
    [
      self.homeModules.common
    ]
    ++ self.lib.modulesDir ./modules;

  nixpkgs.config.allowUnfree = true;
}
