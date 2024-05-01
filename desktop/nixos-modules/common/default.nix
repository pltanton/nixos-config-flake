{ inputs, ... }:
{
  imports = with inputs;[
    self.nixosModules.sops
  ] ++ inputs.self.lib.modulesDir ./.;
}
