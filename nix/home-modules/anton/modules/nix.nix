{pkgs, ...}: {
  nix = {
    package = pkgs.master.nix;

    settings.experimental-features = [ "nix-command" "flakes" ];

    registry = {
      n.flake = inputs.nixpkgs;
      m.flake = inputs.nixpkgs-master;
      s.flake = inputs.nixpkgs-stable;
    };
  };
}
