{ pkgs, ... }: {
  imports = [
    ./keyboard-layout-per-window
    ./flashfocus.nix
    ./swaymonad.nix
    ./autotiling.nix
  ];
}
