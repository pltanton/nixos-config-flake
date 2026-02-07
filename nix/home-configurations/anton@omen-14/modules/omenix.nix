{inputs, ...}: {
  imports = [inputs.omenix.homeManagerModules.default];
  services.omenix.enable = true;
}
