{
  description = "System configuration";

  inputs = {
    nixpkgs-local.url = "github:pltanton/nixpkgs/master";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix.url = "github:nixos/nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = { self, nixpkgs, nur, sops-nix, ... }@inputs: {
    nixosConfigurations = let inherit (inputs.nixpkgs) lib;
    in {
      home-server = lib.nixosSystem {
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

          sops-nix.nixosModules.sops

          ({ pkgs, ... }: {
            nix.settings = {
              # add binary caches
              trusted-public-keys = [
                "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
              ];
              substituters = [
                "https://cache.nixos.org"
              ];
            };
            # Overlays available for each host
            nixpkgs.overlays = [
              nur.overlay
              (final: prev: {
                master = import inputs.nixpkgs-master {
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
                unstable = import inputs.nixpkgs-unstable {
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
