{
  description = "System configuration";

  inputs = {
    # Nixos related inputs
    nixpkgs-local.url = "github:pltanton/nixpkgs/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    # nixpkgs-aws-sam.url = "github:freezeboy/nixpkgs/update-aws-sam-cli";

    nix.url = "github:nixos/nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home-manager and modules
    # home-manager.url = "github:nix-community/home-manager/master";
    home-manager.url = "github:nix-community/home-manager/release-21.05";
    # base16.url = "github:alukardbf/base16-nix";
    base16.url = "github:pltanton/base16-nix";
    nix-doom-emacs.url = "github:vlaci/nix-doom-emacs/master";

    qbpm.url = "github:pvsr/qbpm";

    # Extra flakes with application sets
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nur.url = "github:nix-community/NUR";
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    # My own flakes
    quizanus.url = "git+ssh://gitea@gitea.kaliwe.ru/pltanton/quizanus.git";
    bwmenu.url = "github:pltanton/bitwarden-dmenu";

    deploy-rs.url = "github:serokell/deploy-rs";

    nixpkgs-mozilla.url = "github:mozilla/nixpkgs-mozilla";
    nixpkgs-mozilla.flake = false;

    goose.url = "github:pressly/goose/v3.1.0";
    goose.flake = false;

    doom-emacs.url = "github:hlissner/doom-emacs/develop";
    doom-emacs.flake = false;

    fish-z-plugin.url = "github:jethrokuan/z";
    fish-z-plugin.flake = false;
  };

  outputs = { self, deploy-rs, nixpkgs, nix-doom-emacs, home-manager, nur
    , emacs-overlay, nixpkgs-mozilla, ... }@inputs: {
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
        thinkbook = lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = commonSpecialArgs;
          modules = [
            # A host configuration itself
            (import ./configuration.nix)
            (import ../../configuration-desktop-common)

            # Home manager with default overridings
            home-manager.nixosModules.home-manager

            # Default home-manager user overrides (add modules and special args)
            ({ config, ... }: {
              options.home-manager.users = lib.mkOption {
                type = lib.types.attrsOf (lib.types.submoduleWith {
                  modules = [
                    (import inputs.base16.hmModule)
                    inputs.nix-doom-emacs.hmModule
                    # (import ../../home/common.nix)
                  ];

                  specialArgs = commonSpecialArgs // { super = config; };
                });
              };
            })

            ({ pkgs, ... }: {
              nix = {
                # add binary caches
                binaryCachePublicKeys = [
                  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                  # "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
                  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                ];
                binaryCaches = [
                  "https://cache.nixos.org"
                  # "https://nixpkgs-wayland.cachix.org"
                  "https://nix-community.cachix.org"
                ];
              };
              # Overlays available for each host
              nixpkgs.overlays = [
                nur.overlay
                emacs-overlay.overlay
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

                (import "${nixpkgs-mozilla}/firefox-overlay.nix")
                # inputs.nixpkgs-wayland.overlay
              ];
            })
          ];
        };
      };
    };
}
