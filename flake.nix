{
  description = "Pltanton's desktop flake";

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    # Substituters suitable for build of system
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

  outputs = {flakelight, ...} @ inputs:
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
        # inputs.hyprland.overlays.default
        # inputs.jbr-wayland.overlays.jbrOverlay
        inputs.jetbrains.overlays.default
        (_final: _prev: {
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

      nixDirAliases = {
        nixosConfigurations = ["nixos-configurations"];
        homeConfigurations = ["home-configurations"];

        nixosModules = ["nixos-modules"];
        homeModules = ["home-modules"];
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

    # ─── NIXOS ───────────────────────────────────────────────────────
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
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

    # ─── APPS ────────────────────────────────────────────────────────
    jetbrains = {
      url = "github:liff/jetbrains-flake";
    };

    ddcsync = {
      url = "github:pltanton/ddcsync";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    autobrowser = {
      url = "github:pltanton/autobrowser";
      # url = "path:/home/anton/Workdir/autobrowser";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    firefly-iii-boc-fixer = {
      # url = "github:pltanton/firefly-iii-boc-fixer";
      url = "path:/home/anton/Workdir/firefly-iii-boc-fixer";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    xdph.url = "github:hyprwm/xdg-desktop-portal-hyprland";

    dbeaver = {
      url = "github:padhia/nix-dbeaver";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hycov = {
      url = "github:DreamMaoMao/hycov";
      # inputs.hyprland.follows = "hyprland";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    activate-linux = {
      url = "github:Kljunas2/activate-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    # ─── APPLICATIONS ────────────────────────────────────────────────
    nur.url = "github:nix-community/NUR";
    jbr-wayland.url = "github:BananchickPasha/jbr-wayland-nix";

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

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-cursor-hyprcursor";
      flake = false;
    };

    ccsync = {
      url = "github:CCExtractor/ccsync";
      flake = false;
    };
  };
}
