{ inputs, stateVersion, ... }:

{
  imports = with inputs;[
    self.nixosModules.sops
    home-manager.nixosModules.home-manager
    hyprland.nixosModules.default

    stylix.nixosModules.stylix
  ] ++ (builtins.map
    (name: ./modules + "/${name}")
    (builtins.attrNames (builtins.readDir ./modules))
  );

  time.timeZone = "Asia/Nicosia";

  nixpkgs.overlays = [
    (import ./overlays/customPackages.nix inputs)
    (import ./overlays/scripts)

    (final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      master = import inputs.nixpkgs-master {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      stable = import inputs.nixpkgs-stable {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    })
  ];

  nixpkgs.config = {
    allowBroken = false;
    allowUnfree = true;

    permittedInsecurePackages = [ ];
  };

  system.stateVersion = stateVersion;
}
