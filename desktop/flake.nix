{
  description = "Pltanton's desktop flake";

  inputs = {
    flakelight.url = "github:nix-community/flakelight";

    # Nixos related inputs
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.follows = "nixpkgs-unstable";

    nix.url = "github:nixos/nix";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home-manager and modules
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";

    anyrun.url = "github:Kirottu/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";



    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    base16-schemes.url = "github:tinted-theming/base16-schemes";
    base16-schemes.flake = false;

    base16-rofi.url = "github:tinted-theming/base16-rofi";
    base16-rofi.flake = false;

    # ddcsync.url = "path:/home/anton/Workdir/ddcsync";
    ddcsync.url = "github:pltanton/ddcsync";
    ddcsync.inputs.nixpkgs.follows = "nixpkgs";

    autobrowser.url = "path:/home/anton/Workdir/autobrowser";
    autobrowser.inputs.nixpkgs.follows = "nixpkgs-unstable";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      # url = "github:hyprwm/Hyprland/v0.36.0";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-cursor-hyprcursor";
      flake = false;
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

    hyprfocus = { url = "github:VortexCoyote/hyprfocus"; };
    # hyprpaper = {
    #   url = "github:hyprwm/hyprpaper";
    #   # inputs.nixpkgs.follows = "nixpkgs";
    # };
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

    dbeaver.url = "github:padhia/nix-dbeaver";
    dbeaver.inputs.nixpkgs.follows = "nixpkgs";
  };

  nixConfig = {
    extra-experimental-features = "nix-command flakes";
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];

    auto-optimise-store = true;
  };

  outputs = { flakelight, home-manager, ... }@inputs:
    flakelight ./. {
      inherit inputs;

      nixDir = ./.;
      nixDirAliases = {
        nixosConfigurations = [ "nixos-configurations" ];
        homeConfigurations = [ "home-configurations" ];


        nixosModules = [ "nixos-modules" ];
        homeModules = [ "home-modules" ];
      };
    };
}
