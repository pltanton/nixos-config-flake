{
  pkgs,
  inputs,
  config,
  ...
}: {
  nix = {
    package = pkgs.nix;

    registry = {
      n.flake = inputs.nixpkgs;
    };
  };
}
