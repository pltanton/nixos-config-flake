{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hyprland-config.nix
    ./keybinds.nix
    ./rules.nix
  ];

  home.packages =
    lib.mkIf config.wayland.windowManager.hyprland.enable
    (with pkgs; [
      wl-clipboard

      swaylock-fancy
      wofi-emoji
      pamixer

      playerctl

      # Hyprcursor cursor
      (pkgs.runCommand "moveUp" {} ''
        mkdir -p $out/share/icons
        ln -s ${inputs.rose-pine-hyprcursor} $out/share/icons/rose-pine-hyprcursor
      '')
    ]);
}
