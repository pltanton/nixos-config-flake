{inputs, ...}: {
  imports = [inputs.omenix.nixosModules.default];

  programs.omenix.enable = true;
  services.omenix-daemon.enable = true;
}
