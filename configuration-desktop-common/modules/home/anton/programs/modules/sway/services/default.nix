{ pkgs, ... }: {
  imports = [
    ./keyboard-layout-per-window
    ./flashfocus.nix
    ./clipman.nix
    ./wob.nix
    ./swaymonad.nix
  ];
}
