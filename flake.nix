{
  description = "System configuration";

  inputs = {
    # Nixos related inputs
    nixpkgs-local.url = "github:pltanton/nixpkgs/master";
    # nixpkgs-local.url = "/home/anton/Workdir/nixpkgs";
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-21.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-21.05";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-20.09";
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
    nixpkgs-wayland.url = "github:colemickens/nixpkgs-wayland";
    nur.url = "github:nix-community/NUR";
    emacs-overlay.url = "github:nix-community/emacs-overlay";

    # My own flakes
    quizanus.url = "git+ssh://gitea@gitea.kaliwe.ru/pltanton/quizanus.git";
    bwmenu.url = "github:pltanton/bitwarden-dmenu";

    deploy-rs.url = "github:serokell/deploy-rs";

    nixpkgs-mozilla.url = "github:mozilla/nixpkgs-mozilla";
    nixpkgs-mozilla.flake = false;

  };

  outputs = { self, deploy-rs, nixpkgs, nix-doom-emacs, home-manager, nur
    , emacs-overlay, nixpkgs-mozilla, ... }@inputs: {
      nixosConfigurations = let
        inherit (inputs.nixpkgs) lib;

        # Special args for booth home-manager and nixos system configuration
        buildSpecialArgs = name: {
          inherit inputs; # Add an inputs raw link

          homeBaseDir = ./home;
          # Add secrets if present
          secrets = let secretsPath = ./machines + "/${name}/secrets.nix";
          in if (builtins.pathExists secretsPath) then
            import secretsPath
          else
            { };
        };

        # Default home-manager user overrides (add modules and special args)
        hm-nixos-as-super = name:
          { config, ... }: {
            options.home-manager.users = lib.mkOption {
              type = lib.types.attrsOf (lib.types.submoduleWith {
                modules = [
                  (import inputs.base16.hmModule)
                  inputs.nix-doom-emacs.hmModule
                  (import ./home/common.nix)
                ];

                specialArgs = (buildSpecialArgs name) // { super = config; };
              });
            };
          };

        # Hosts contains an array for each system
        hosts = (builtins.attrNames (builtins.readDir ./machines));

        # Main host declaration
        mkHost = name:
          lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = (buildSpecialArgs name);
            modules = [
              # A host configuration itself
              (import (./machines + "/${name}/configuration.nix"))

              # Home manager with default overridings
              home-manager.nixosModules.home-manager
              (hm-nixos-as-super name)
              ({ pkgs, ... }: {
                nix = {
                  # add binary caches
                  binaryCachePublicKeys = [
                    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                    "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
                    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                  ];
                  binaryCaches = [
                    "https://cache.nixos.org"
                    "https://nixpkgs-wayland.cachix.org"
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
                ];
              })
            ];
          };
      in lib.genAttrs hosts mkHost;

      # devShell.x86_64-linux = pkgs.mkShell {
      #   buildInputs = [ deploy-rs.packages.x86_64-linux.deploy-rs pkgs.gnumake ];
      # };

      deploy.nodes = {
        hz1 = {
          hostname = "hz1.kaliwe.ru";
          fastConnection = true;
          profiles = {
            system = {
              sshUser = "root";
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.hz1;
              # user = "root";
            };
          };
        };

        thinkpad-x1 = {
          hostname = "localhost";
          fastConnection = true;
          profiles = {
            system = {
              sshUser = "anton";
              path = deploy-rs.lib.x86_64-linux.activate.nixos
                self.nixosConfigurations.thinkpad-x1;
              user = "anton";
            };
          };
        };
      };
    };
}
