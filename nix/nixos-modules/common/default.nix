{
  inputs,
  stateVersion,
  ...
}: {
  imports = with inputs;
    [
      sops-nix.nixosModules.sops
    ]
    ++ inputs.self.lib.modulesDir ./.;

  system.stateVersion = stateVersion;
}
