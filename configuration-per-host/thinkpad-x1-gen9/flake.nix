{
  description = "System configuration";

  inputs = {
    # Nixos related inputs
    # nixpkgs-local.url = "path:/home/anton/Workdir/nixpkgs";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nix.url = "github:nixos/nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home-manager and modules
    # home-manager.url = "github:nix-community/home-manager/master";
    home-manager.url = "path:/home/anton/Workdir/home-manager";
    # home-manager.url = "github:nix-community/home-manager/release-22.05";
    # base16.url = "github:alukardbf/base16-nix";
    # base16.url = "github:pltanton/base16-nix";

    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";

    base16-schemes = {
      url = "github:tinted-theming/base16-schemes";
      flake = false;
    };
    stylix.url = "github:danth/stylix";
    base16-rofi = {
      url = "github:tinted-theming/base16-rofi";
      flake = false;
    };

    # ddcsync.url = "path:/home/anton/Workdir/ddcsync";
    ddcsync.url = "github:pltanton/ddcsync";
    ddcsync.inputs.nixpkgs.follows = "nixpkgs";

    hyprland = {
      # url = "github:hyprwm/Hyprland/8531d1d7a67f6213de73466f0351a1ae709f8f4f";
      url = "github:hyprwm/Hyprland";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs"; # not mandatory but recommended
    };
    activate-linux = {
      url = "github:Kljunas2/activate-linux";
      inputs.nixpkgs.follows = "nixpkgs"; # not mandatory but recommended
    };
    jetbrains-flake = {
      url = "github:liff/jetbrains-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Extra flakes with application sets
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nur.url = "github:nix-community/NUR";

    emacs-catppuccin.url = "github:catppuccin/emacs";
    emacs-catppuccin.flake = false;

    emacs-overlay.url =
      "github:nix-community/emacs-overlay/c16be6de78ea878aedd0292aa5d4a1ee0a5da501";
    # "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";

    # My own flakes
    bwmenu.url = "github:pltanton/bitwarden-dmenu";

    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    doom-emacs.url = "github:doomemacs/doomemacs";
    doom-emacs.flake = false;

    fish-async-prompt-plugin.url = "github:acomagu/fish-async-prompt";
    fish-async-prompt-plugin.flake = false;
    fish-colored-man-plugin.url = "github:decors/fish-colored-man";
    fish-colored-man-plugin.flake = false;
    fish-grc.url = "github:oh-my-fish/plugin-grc";
    fish-grc.flake = false;

    swaylock-effects-src.url = "github:mortie/swaylock-effects";
    swaylock-effects-src.flake = false;

  };

  outputs = { self, nixpkgs, home-manager, nur, nix-alien, emacs-overlay
    , mach-nix, hyprland, hyprpaper, ddcsync, jetbrains-flake, stylix
    , nix-doom-emacs, anyrun, sops-nix, ... }@inputs: {
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
        thinkpad-x1-gen9 = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = commonSpecialArgs;
          modules = [
            # A host configuration itself
            (import ./configuration.nix)
            (import ../../configuration-desktop-common)
            (import ../../configuration-common)
            sops-nix.nixosModules.sops

            # Home manager with default overridings
            home-manager.nixosModules.home-manager
            hyprland.nixosModules.default
            stylix.nixosModules.stylix

            # Default home-manager user overrides (add modules and special args)
            ({ config, ... }: {
              options.home-manager.users = lib.mkOption {
                type = lib.types.attrsOf (lib.types.submoduleWith {
                  modules = [
                    # (import inputs.base16.hmModule)
                    nix-doom-emacs.hmModule
                    # hyprland.homeManagerModules.default
                    ddcsync.homeManagerModules.default
                    anyrun.homeManagerModules.default
                    sops-nix.homeManagerModules.sops
                  ];

                  specialArgs = commonSpecialArgs // { super = config; };
                });
              };
            })

            ({ pkgs, ... }: {
              nix.settings = {
                builders-use-substitutes = true;
                trusted-public-keys = [
                  "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
                  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                  "emacsng.cachix.org-1:i7wOr4YpdRpWWtShI8bT6V7lOTnPeI7Ho6HaZegFWMI="
                  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                  "liff.cachix.org-1:Uid73LCbEljychK4hx5pn3BkTehHPDBt+S717gFBp90="
                  "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                  "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
                ];
                substituters = [
                  "https://nixpkgs-wayland.cachix.org"
                  "https://nix-community.cachix.org"
                  "https://emacsng.cachix.org"
                  "https://cache.nixos.org"
                  "https://hyprland.cachix.org"
                  "https://anyrun.cachix.org"
                ];
              };

              nixpkgs.overlays = [
                nur.overlay
                emacs-overlay.overlay
                #nix-alien.overlay
                hyprland.overlays.default
                hyprpaper.overlays.default
                ddcsync.overlays.default
                jetbrains-flake.overlays.default

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

                inputs.nixpkgs-wayland.overlay
              ];
            })
          ];
        };
      };
    };
}
