{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix.url = "github:nixos/nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager.url = "github:rycee/home-manager";
    #home-manager.url = "/home/anton/workdir/home-manager";
    base16.url = "github:alukardbf/base16-nix";

    nixpkgs-wayland.url = "github:colemickens/nixpkgs-wayland";

    nixDoomEmacs.url = "github:vlaci/nix-doom-emacs/develop";
    nixDoomEmacs.flake = false;

    swaylock-effects.url = "github:mortie/swaylock-effects";
    swaylock-effects.flake = false;

    quizanus.url = "git+ssh://gitea@gitea.kaliwe.ru/pltanton/quizanus.git";
    #quizanus.url = "/home/anton/workdir/quizanus";
  };

  outputs = inputs: {
    nixosConfigurations = let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
      inherit (inputs.nixpkgs) lib;

      # Things in this set are passed to modules and accessible
      # in the top-level arguments (e.g. `{ pkgs, lib, inputs, ... }:`).
      specialArgs = { inherit inputs; };

      hm-nixos-as-super = name:
        { config, ... }: {
          # Submodules have merge semantics, making it possible to amend
          # the `home-manager.users` submodule for additional functionality.
          options.home-manager.users = lib.mkOption {
            type = lib.types.attrsOf (lib.types.submoduleWith {
              modules = [ (import inputs.base16.hmModule) ];
              # Makes specialArgs available to Home Manager modules as well.
              specialArgs = specialArgs // {
                secrets = let secretsPath = ./machines + "/${name}/secrets.nix";
                in if (builtins.pathExists secretsPath) then
                  import secretsPath
                else
                  { };
                super = config;
              };
            });
          };
        };

      hosts = (builtins.attrNames (builtins.readDir ./machines));

      mkHost = name:
        lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (import (./machines + "/${name}/configuration.nix"))
            inputs.home-manager.nixosModules.home-manager
            (hm-nixos-as-super name)
            ({ pkgs, config, ... }: {
              config = {
                nix = {
                  # add binary caches
                  binaryCachePublicKeys = [
                    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                    "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
                  ];
                  binaryCaches = [
                    "https://cache.nixos.org"
                    "https://nixpkgs-wayland.cachix.org"
                  ];
                };

                nixpkgs.overlays = [ inputs.nixpkgs-wayland.overlay inputs.quizanus.overlay ];
              };
            })
          ];
          specialArgs = { inherit inputs name specialArgs; };
          specialArgs.secrets =
            let secretsPath = ./machines + "/${name}/secrets.nix";
            in if (builtins.pathExists secretsPath) then
              import secretsPath
            else
              { };
        };
    in lib.genAttrs hosts mkHost;
  };
}
