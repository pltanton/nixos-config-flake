{inputs, ...}: {
  imports = with inputs; [
    autobrowser.homeModules.default

    ./sketchybar
    ./aerospace.nix
    ./alacritty.nix
    ./autobrowser.nix
    ./darwin.nix
    ./fish.nix
    ./ghostty.nix
    ./jankyborders.nix
    ./mac-packages.nix
    ./stylix.nix
  ];

  nixpkgs.overlays = with inputs; [
    autobrowser.overlays.default
  ];
}
