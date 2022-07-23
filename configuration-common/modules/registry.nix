{ pkgs, inputs, ... }: {
  nix.registry.n.flake = inputs.nixpkgs;
  nix.registry.m.flake = inputs.nixpkgs-master;
}
