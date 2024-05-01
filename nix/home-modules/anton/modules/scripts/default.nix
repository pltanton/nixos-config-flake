{ inputs, ... }: {
  nixpkgs.overlays = [ (import ./overlay.nix) ];
}
