{ pkgs, inputs, ... }@value:

{
  nixpkgs.overlays = [
    (import ../overlays/customPackages.nix)
    #(import ../overlays/taffybar.nix)
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  home = {
    stateVersion = "20.09";
  };
}
