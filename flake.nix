{
  description = "Pltanton's desktop flake";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    auto-optimise-store = true;
  };

  outputs = {
    flakelight,
    home-manager,
    ...
  } @ inputs:
    flakelight ./. {
      inherit inputs;

      lib = {
        modulesDir = with builtins;
          dir: (
            map
            (name: dir + "/${name}")
            (attrNames (removeAttrs (readDir dir) ["default.nix"]))
          );
      };

      withOverlays = [
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
      ];

      nixDir = ./nix;
      nixDirAliases = {
        nixosConfigurations = ["nixos-configurations"];
        homeConfigurations = ["home-configurations"];

        nixosModules = ["nixos-modules"];
        homeModules = ["home-modules"];
      };
    };

  inputs = {
    flakelight.url = "github:nix-community/flakelight";

    # ─── NIXOS ───────────────────────────────────────────────────────
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.follows = "nixpkgs-unstable";

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

    base16-schemes.url = "github:tinted-theming/base16-schemes";
    base16-schemes.flake = false;

    base16-rofi.url = "github:tinted-theming/base16-rofi";
    base16-rofi.flake = false;

    # ─── APPS ────────────────────────────────────────────────────────
    ddcsync = {
      url = "github:pltanton/ddcsync";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    autobrowser = {
      url = "path:/home/anton/Workdir/autobrowser";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dbeaver = {
      url = "github:padhia/nix-dbeaver";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hycov = {
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    activate-linux = {
      url = "github:Kljunas2/activate-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ─── APPLICATION SETS ────────────────────────────────────────────
    nur.url = "github:nix-community/NUR";

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

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-cursor-hyprcursor";
      flake = false;
    };
  };
}
