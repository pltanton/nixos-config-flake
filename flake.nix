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
        (_final: _prev: let
          nixpkgs-flake = import inputs.nixpkgs {
            inherit (_prev) system;
            config.allowUnfree = true;
          };

          unstable = import inputs.nixpkgs-unstable {
            inherit (_prev) system;
            config.allowUnfree = true;
          };

          master = import inputs.nixpkgs-master {
            inherit (_prev) system;
            config.allowUnfree = true;
          };

          stable = import inputs.nixpkgs-stable {
            inherit (_prev) system;
            config.allowUnfree = true;
          };

          nixpkgs-sof = import inputs.nixpkgs-sof {
            inherit (_prev) system;
            config.allowUnfree = true;
          };
          # nixpkgs-local = import inputs.nixpkgs-local {
          #   inherit (_prev) system;
          #   config.allowUnfree = true;
          # };
        in {
          inherit nixpkgs-flake unstable master stable;
          inherit (nixpkgs-sof) sof-firmware;
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

    # ─── APPS ────────────────────────────────────────────────────────
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

    try-rs = {
      url = "github:tassiovirginio/try-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    activate-linux = {
      url = "github:Kljunas2/activate-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
    matugen.url = "github:InioX/Matugen";
    hyprdynamicmonitors.url = "github:fiffeek/hyprdynamicmonitors";
    # omenix.url = "github:noahpro99/omenix";
    omenix.url = "path:/home/anton/Workdir/omenix";
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    danksearch = {
      url = "github:AvengeMedia/danksearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprshutdown = {
      url = "github:hyprwm/hyprshutdown";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    catppuccin-zen = {
      url = "github:catppuccin/zen-browser";
      flake = false;
    };

    ccsync = {
      url = "github:CCExtractor/ccsync";
      flake = false;
    };
  };
}
