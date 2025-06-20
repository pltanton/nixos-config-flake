{pkgs, ...}: {
  nix = {
    # enable = true;
    settings.experimental-features = ["nix-command" "flakes"];
    package = pkgs.nix;
  };
}
