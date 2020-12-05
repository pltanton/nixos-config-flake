{
  description = "System configuration";

  inputs = {
    # Nixos related inputs
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:pltanton/nixpkgs/nixos-20.09";
    nixpkgs.url = "/home/anton/Workdir/nixpkgs";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-20.09";
    nix.url = github:nixos/nix;
    nixos-hardware.url = github:NixOS/nixos-hardware/master;

    # Home-manager and modules
    home-manager.url = github:rycee/home-manager;
    base16.url = github:alukardbf/base16-nix;
    nix-doom-emacs.url = github:vlaci/nix-doom-emacs/master;

    # Extra flakes with application sets
    nixpkgs-wayland.url = github:colemickens/nixpkgs-wayland;
    nur.url = github:nix-community/NUR;
    emacs-overlay.url = github:nix-community/emacs-overlay;

    # My own flakes
    quizanus.url = git+ssh://gitea@gitea.kaliwe.ru/pltanton/quizanus.git;

  };

  outputs = inputs: {
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
              specialArgs = (buildSpecialArgs name) // {
                super = config;
              };
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
            inputs.home-manager.nixosModules.home-manager (hm-nixos-as-super name)

            # Some defaults like binary caches, that available for each host
            ({ pkgs, config, ... }: {
              config = {
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
                nixpkgs.overlays = [ inputs.nur.overlay inputs.emacs-overlay.overlay ];
              };
            })
          ];
        };
    in lib.genAttrs hosts mkHost;
  };
}
