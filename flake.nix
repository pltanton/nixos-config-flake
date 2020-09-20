{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix.url = "github:nixos/nix/6ff9aa8df7ce8266147f74c65e2cc529a1e72ce0";
    #home-manager.url = "github:rycee/home-manager";
    home-manager.url = "/home/anton/workdir/home-manager";
    base16.url = "github:alukardbf/base16-nix";
    zsh-nix-shell = {
      url = "github:chisui/zsh-nix-shell";
      flake = false;
    };

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

      hm-nixos-as-super = name: { config, ... }: {
        # Submodules have merge semantics, making it possible to amend
        # the `home-manager.users` submodule for additional functionality.
        options.home-manager.users = lib.mkOption {
          type = lib.types.attrsOf (lib.types.submoduleWith {
            modules = [ (import inputs.base16.hmModule) ];
            # Makes specialArgs available to Home Manager modules as well.
            specialArgs = specialArgs // {
              # Allow accessing the parent NixOS configuration.
              secrets =
                let secretsPath = ./machines + "/${name}/secrets.nix";
                in if (builtins.pathExists secretsPath) then import secretsPath else { };
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
            ({ pkgs, ... }: { nixpkgs.overlays = [ inputs.quizanus.overlay ]; })
          ];
          specialArgs = { inherit inputs name specialArgs; };
          specialArgs.secrets =
            let secretsPath = ./machines + "/${name}/secrets.nix";
            in if (builtins.pathExists secretsPath) then import secretsPath else { };
        };
    in lib.genAttrs hosts mkHost;
  };
}
