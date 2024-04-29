{ pkgs, ... }: {
  nix = {
    package = pkgs.nixStable;
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
    '';
  };
}
