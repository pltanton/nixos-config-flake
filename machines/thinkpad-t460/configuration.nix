{ options, config, pkgs, lib, inputs, ... }:

{
  imports = (builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules)))
    ++ (builtins.map (name: ../../common-desktop + "/${name}")
      (builtins.attrNames (builtins.readDir ../../common-desktop)))
    ++ (builtins.map (name: ../../common-machines + "/${name}")
      (builtins.attrNames (builtins.readDir ../../common-machines)));

  time.timeZone = "Europe/Moscow";

  nixpkgs.overlays = [
    (import ../../overlays/customPackages.nix)
    inputs.nixpkgs-wayland.overlay
  ];

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
  programs.fish.enable = true;
  programs.adb.enable = true;

  networking.hostName = "thinkpad-t460";
}
