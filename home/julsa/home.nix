{ pkgs, inputs, ... }@value:

{
  nixpkgs.overlays = [
    (import ../../overlays/customPackages.nix)
    (import ../../overlays/taffybar.nix)
  ];

  imports = builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  home = {
    keyboard = {
      layout = "us,ru";
    };
  };
}
