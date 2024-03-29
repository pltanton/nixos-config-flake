{
  description = "System configuration";

  inputs = {
    # Nixos related inputs
    # nixpkgs-local.url = "github:pltanton/nixpkgs/master";
    nixpkgs-local.url = "path:/home/anton/Workdir/nixpkgs";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.05";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix.url = "github:nixos/nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home-manager and modules
    home-manager.url = "github:nix-community/home-manager/master";
    base16.url = "github:pltanton/base16-nix";

    ddcsync.url = "path:/home/anton/Workdir/ddcsync";
    ddcsync.inputs.nixpkgs.follows = "nixpkgs";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    activate-linux = {
      url = "github:Kljunas2/activate-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    swaymonad = {
      url = "github:pltanton/swaymonad";
      inputs.nixpkgs.follows = "nixpkgs";
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

    doom-emacs.url = "github:doomemacs/doomemacs";
    doom-emacs.flake = false;

    fish-z-plugin.url = "github:jethrokuan/z";
    fish-z-plugin.flake = false;
    fish-colored-man-plugin.url = "github:decors/fish-colored-man";
    fish-colored-man-plugin.flake = false;
    fish-grc.url = "github:oh-my-fish/plugin-grc";
    fish-grc.flake = false;
  };

  outputs = { self, nixpkgs, home-manager, nur, nix-alien, emacs-overlay
    , mach-nix, jetbrains-flake, hyprland, hyprpaper, ddsync, ... }@inputs: {
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
            # hyprland.nixosModules.default
            # {
            #   programs.hyprland.package = null;
            # }

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
                  modules = [
                    (import inputs.base16.hmModule)
                    hyprland.homeManagerModules.default
                    ddcsync.homeManagerModules.default
                  ];

                  specialArgs = commonSpecialArgs // { super = config; };
                });
              };
            })

            ({ pkgs, ... }: {
              nix.settings = {
                # add binary caches
                # trusted-public-keys = [
                trusted-public-keys = [
                  "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
                  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                  "emacsng.cachix.org-1:i7wOr4YpdRpWWtShI8bT6V7lOTnPeI7Ho6HaZegFWMI="
                  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                  "liff.cachix.org-1:Uid73LCbEljychK4hx5pn3BkTehHPDBt+S717gFBp90="
                  "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                ];
                # binary-caches = [
                substituters = [
                  "https://nixpkgs-wayland.cachix.org"
                  "https://nix-community.cachix.org"
                  "https://emacsng.cachix.org"
                  "https://cache.nixos.org"
                  "https://hyprland.cachix.org"
                ];
              };

              nixpkgs.overlays = [
                nur.overlay
                emacs-overlay.overlay
                nix-alien.overlay
                jetbrains-flake.overlay
                hyprland.overlays.default
                hyprpaper.overlays.default

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
                  local = import inputs.nixpkgs-local {
                    system = "x86_64-linux";
                    config.allowUnfree = true;
                  };
                })

                inputs.nixpkgs-wayland.overlay
              ];
            })
          ];
        };
      };
    };
}
