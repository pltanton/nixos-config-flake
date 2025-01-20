{inputs, ...}: {
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';

    registry = {
      n.flake = inputs.nixpkgs;
      m.flake = inputs.nixpkgs-master;
      s.flake = inputs.nixpkgs-stable;
    };

    settings = {
      builders-use-substitutes = true;
      auto-optimise-store = false;

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://cache.nixos.org"
      ];
    };
  };
}
