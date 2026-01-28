{
  description = "Pltanton's desktop flake";

  nixConfig = {
    experimental-features = "nix-command flakes";

    extra-substituters = [
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs = {
    flakelight,
    flakelight-darwin,
    ...
  } @ inputs:
    flakelight ./. {
      inherit inputs;

      imports = [flakelight-darwin.flakelightModules.default];

      lib = {
        modulesDir = with builtins;
          dir: (
            map
            (name: dir + "/${name}")
            (attrNames (removeAttrs (readDir dir) ["default.nix"]))
          );
      };

      lib = {};

      withOverlays = [
        (_final: _prev: {
          nixpkgs-flake = import inputs.nixpkgs {
            system = _prev.system;
            config.allowUnfree = true;
          };

          unstable = import inputs.nixpkgs-unstable {
            system = _prev.system;
            config.allowUnfree = true;
          };

          master = import inputs.nixpkgs-master {
            system = _prev.system;
            config.allowUnfree = true;
          };

          stable = import inputs.nixpkgs-stable {
            system = _prev.system;
            config.allowUnfree = true;
          };

         sof-firmware = (import inputs.nixpkgs-sof {
            system = _prev.system;
            config.allowUnfree = true;
          }).sof-firmware;

          #local = import inputs.nixpkgs-local {
          #  system = _prev.system;
          #  config.allowUnfree = true;
          #};
        })
      ];

      nixDirAliases = {
        nixosConfigurations = ["nixos-configurations"];
        homeConfigurations = ["home-configurations"];
        darwinConfigurations = ["darwin-configurations"];

        nixosModules = ["nixos-modules"];
        homeModules = ["home-modules"];
        darwinModules = ["darwin-modules"];
      };

      devShell.packages = pkgs: with pkgs; [alejandra dprint];

      formatters = {
        "*.yml" = "dprint fmt";
        "*.md" = "dprint fmt";
        "*.nix" = "alejandra";
      };
    };

  inputs = {
    flakelight.url = "github:nix-community/flakelight";
    flakelight-darwin.url = "github:cmacrae/flakelight-darwin";

    # ─── NIXOS ───────────────────────────────────────────────────────
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-sof.url = "github:r-ryantm/nixpkgs/auto-update/sof-firmware";
    # nixpkgs-flakehub.url = "https://flakehub.com/f/NixOS/nixpkgs/*";
    nixpkgs.follows = "nixpkgs-unstable";
    # nixpkgs-local.url = "path:/Users/anton/Workdir/nixpkgs";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix.url = "github:Mic92/sops-nix";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ─── APPS ────────────────────────────────────────────────────────
    zen-browser.url = "github:youwen5/zen-browser-flake";
    lazyvim.url = "github:pfassina/lazyvim-nix";

    ddcsync = {
      url = "github:pltanton/ddcsync";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    autobrowser = {
      url = "github:pltanton/autobrowser";
      # url = "path:/Users/anton/Workdir/autobrowser";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    firefly-iii-boc-fixer = {
      url = "github:pltanton/firefly-iii-boc-fixer";
      # url = "path:/home/anton/Workdir/firefly-iii-boc-fixer";
    };

    activate-linux = {
      url = "github:Kljunas2/activate-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    # ─── APPLICATIONS ────────────────────────────────────────────────
    nur.url = "github:nix-community/NUR";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    # ─── NON FLAKE INPUTS ────────────────────────────────────────────

    fish-async-prompt-plugin = {
      url = "github:acomagu/fish-async-prompt";
      flake = false;
    };
    fish-colored-man-plugin = {
      url = "github:decors/fish-colored-man";
      flake = false;
    };
    fish-grc = {
      url = "github:oh-my-fish/plugin-grc";
      flake = false;
    };

    base16-schemes = {
      url = "github:tinted-theming/base16-schemes";
      flake = false;
    };

    base16-rofi = {
      url = "github:tinted-theming/base16-rofi";
      flake = false;
    };

    ccsync = {
      url = "github:CCExtractor/ccsync";
      flake = false;
    };
  };
}
