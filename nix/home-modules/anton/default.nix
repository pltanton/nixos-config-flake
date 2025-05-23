{inputs, ...}: {
  imports = inputs.self.lib.modulesDir ./modules;

  nixpkgs.config.allowUnfree = true;
}
