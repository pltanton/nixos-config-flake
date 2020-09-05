{ options, config, pkgs, lib, inputs, ... }:

let
  secrets = import ./secrets.nix;
in rec {
  imports = builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules));

  time.timeZone = "Europe/Moscow";

  nixpkgs.overlays =
    [ (import ../../overlays/customPackages.nix) ];

  nixpkgs.config = {
    allowBroken = true;
    allowUnfree = true;
  };


  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  programs.zsh.enable = true;
  programs.adb.enable = true;

  system = {
    autoUpgrade.enable = true;
    autoUpgrade.channel = "https://nixos.org/channels/nixos-unstable";
    stateVersion = "unstable";
  };
}
