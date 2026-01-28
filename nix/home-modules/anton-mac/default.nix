{inputs, ...}: {
  imports = with inputs; [
    autobrowser.homeModules.default

    ./aerospace.nix
    ./alacritty.nix
    ./autobrowser.nix
    ./darwin.nix
    ./fish.nix
    ./ghostty.nix
    ./jankyborders.nix
    ./mac-packages.nix
    ./theme.nix
  ];

  nixpkgs.overlays = with inputs; [
    autobrowser.overlays.default
  ];
}
