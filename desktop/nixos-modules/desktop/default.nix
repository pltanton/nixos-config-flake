{ inputs, stateVersion, ... }:

{
  imports = with inputs;[
    self.nixosModules.common

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
