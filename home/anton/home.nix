{ pkgs, inputs, ... }@value:

{
  nixpkgs.overlays = [
    (import ../../overlays/customPackages.nix)
    (import ../../overlays/.nix)
  ];
  nixpkgs.config.pulseaudio = true;

  imports = [../common.nix] ++ builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  home = {
    keyboard = {
      layout = "us,ru";
      variant = "dvorak,";
    };
  };
}
