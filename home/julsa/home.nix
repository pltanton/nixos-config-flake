{ pkgs, inputs, ... }@value:

{
  # nixpkgs.overlays = [
  #   (import ../../overlays/customPackages.nix)
  #   (import ../../overlays/scripts)
  # ];

  imports = builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  home = { keyboard = { layout = "us,ru"; }; };
}
