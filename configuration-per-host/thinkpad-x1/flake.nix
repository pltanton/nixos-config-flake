{
  description = "System configuration";

  inputs = {
    # Nixos related inputs
    nixpkgs-local.url = "github:pltanton/nixpkgs/master";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    nix.url = "github:nixos/nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home-manager and modules
    # home-manager.url = "github:nix-community/home-manager/master";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    # base16.url = "github:alukardbf/base16-nix";
    base16.url = "github:pltanton/base16-nix";

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs"; # not mandatory but recommended
    };
    activate-linux = {
      url = "github:Kljunas2/activate-linux";
      inputs.nixpkgs.follows = "nixpkgs"; # not mandatory but recommended
    };
    swaymonad = {
      url = "github:pltanton/swaymonad";
      inputs.nixpkgs.follows = "nixpkgs"; # not mandatory but recommended
    };

    # Extra flakes with application sets
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nur.url = "github:nix-community/NUR";
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    # My own flakes
    quizanus.url = "git+ssh://gitea@gitea.kaliwe.ru/pltanton/quizanus.git";
    bwmenu.url = "github:pltanton/bitwarden-dmenu";

    goose.url = "github:pressly/goose/v3.1.0";
    goose.flake = false;

    doom-emacs.url = "github:hlissner/doom-emacs/develop";
    doom-emacs.flake = false;

    fish-z-plugin.url = "github:jethrokuan/z";
    fish-z-plugin.flake = false;
    fish-colored-man-plugin.url = "github:decors/fish-colored-man";
    fish-colored-man-plugin.flake = false;
    fish-grc.url = "github:oh-my-fish/plugin-grc";
    fish-grc.flake = false;

    swaylock-effects-src.url = "github:mortie/swaylock-effects";
    swaylock-effects-src.flake = false;

  };

  outputs = { self, nixpkgs, home-manager, nur, nix-alien, emacs-overlay, ...
    }@inputs: {
      nixosConfigurations = let
        inherit (inputs.nixpkgs) lib;

        # Special args for booth home-manager and nixos system configuration
        commonSpecialArgs = {
          inherit inputs; # Add an inputs raw link

          homeBaseDir = ../../home;
          # Add secrets if present
          secrets = let secretsPath = ./secrets.nix;
          in if (builtins.pathExists secretsPath) then
            import secretsPath
          else
            { };
        };

      in {
        thinkpad-x1 = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = commonSpecialArgs;
          modules = [
            # A host configuration itself
            (import ./configuration.nix)
            (import ../../configuration-desktop-common)
            (import ../../configuration-common)

            # Home manager with default overridings
            home-manager.nixosModules.home-manager

            # Default home-manager user overrides (add modules and special args)
            ({ config, ... }: {
              options.home-manager.users = lib.mkOption {
                type = lib.types.attrsOf (lib.types.submoduleWith {
                  modules = [ (import inputs.base16.hmModule) ];

                  specialArgs = commonSpecialArgs // { super = config; };
                });
              };
            })

            ({ pkgs, ... }: {
              nix = {
                # add binary caches
                # trusted-public-keys = [
                binaryCachePublicKeys = [
                  "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
                  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                  "emacsng.cachix.org-1:i7wOr4YpdRpWWtShI8bT6V7lOTnPeI7Ho6HaZegFWMI="
                  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                ];
                # binary-caches = [
                binaryCaches = [
                  "https://nixpkgs-wayland.cachix.org"
                  "https://nix-community.cachix.org"
                  "https://emacsng.cachix.org"
                  "https://cache.nixos.org"
                ];
              };

              nixpkgs.overlays = [
                nur.overlay
                emacs-overlay.overlay
                nix-alien.overlay

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
                })

                # inputs.nixpkgs-wayland.overlay
              ];
            })
          ];
        };
      };
    };
}
