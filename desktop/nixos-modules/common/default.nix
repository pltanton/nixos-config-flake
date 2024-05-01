{ inputs, stateVersion, ... }:

{
  imports = with inputs;[
    self.nixosModules.sops
    home-manager.nixosModules.home-manager
    hyprland.nixosModules.default
    stylix.nixosModules.stylix


  ] ++ self.lib.modulesDir ./.;

  time.timeZone = "Asia/Nicosia";

  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;

    permittedInsecurePackages = [ ];
  };


  system.stateVersion = stateVersion;
}
