{ pkgs, inputs, ... }:

{

  # nixpkgs.overlays = [
  #   inputs.nur.overlay
  #   (import ../../overlays/customPackages.nix)
  #   (import ../../overlays/scripts)
  # ];
  # nixpkgs.config.pulseaudio = true;

  # modules = [
  #   # (import inputs.base16.hmModule)
  #   inputs.nix-doom-emacs.hmModule
  #   # (import ./home/common.nix)
  # ];

  # nixpkgs.config = {
  #   allowUnfree = true;
  #   allowBroken = true;
  # };

  # home = {
  #   keyboard = {
  #     layout = "us,ru";
  #     variant = "dvorak,";
  #   };
  # };
  home = { stateVersion = "22.05"; };
}
