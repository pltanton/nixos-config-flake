{ options, config, pkgs, lib, inputs, ... }:

{
  imports = (builtins.map (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules)));

  # time.timeZone = "Europe/Moscow";
  time.timeZone = "Asia/Nicosia";
  # time.timeZone = "Europe/Belgrade";

  nixpkgs.overlays = [
    (import ./overlays/customPackages.nix inputs)
    (import ./overlays/scripts)
    # inputs.nixpkgs-wayland.overlay
    (self: super:
      {

      })
  ];

  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;

    permittedInsecurePackages = [  ];
  };

  networking.firewall.enable = false;

  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.adb.enable = true;
}
