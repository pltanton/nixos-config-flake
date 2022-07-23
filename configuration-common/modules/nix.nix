{ pkgs, ... }: {
  nix = {
    package = pkgs.master.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
    '';
  };
}
