{
  description = "System configuration";

  inputs = {
    nixpkgs-local.url = "github:pltanton/nixpkgs/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-21.11";
    nix.url = "github:nixos/nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = let inherit (inputs.nixpkgs) lib;
    in {
      hz1 = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs; # Add an inputs raw link
          # Add secrets if present
          secrets = import ./secrets.nix;
        };

        modules = [
          # The host configuration itself
          (import ./configuration.nix)
          (import ../../configuration-common)

          ({ pkgs, ... }: {
            nix = {
              # add binary caches
              binaryCachePublicKeys = [
                "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
              ];
              binaryCaches = [
                "https://cache.nixos.org"
                "https://nix-community.cachix.org"
              ];
            };
            # Overlays available for each host
            nixpkgs.overlays = [
              (final: prev: {
                master = import inputs.nixpkgs-master {
                  system = "x86_64-linux";
                  config.allowUnfree = true;
                };
                unstable = import inputs.nixpkgs-unstable {
                  system = "x86_64-linux";
                  config.allowUnfree = true;
                };
                stable = import inputs.nixpkgs-stable {
                  system = "x86_64-linux";
                  config.allowUnfree = true;
                };
                local = import inputs.nixpkgs-local {
                  system = "x86_64-linux";
                  config.allowUnfree = true;
                };
              })
            ];
          })
        ];
      };
    };
  };
}
