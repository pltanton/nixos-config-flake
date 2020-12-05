{ pkgs, inputs, ... }@value:

{
  nixpkgs.overlays = [
    (import ../../overlays/customPackages.nix)
    (import ../../overlays/.nix)
  ];
  nixpkgs.config.pulseaudio = true;

  imports = builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  home = {
    keyboard = {
      layout = "us,ru";
      variant = "dvorak,";
    };
  };
}
