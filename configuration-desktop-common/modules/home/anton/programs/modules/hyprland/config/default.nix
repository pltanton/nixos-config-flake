{ osConfig, config, lib, pkgs, inputs, ... }: {

  imports = [ ./keybinds.nix ./hyprland-config.nix ./rules.nix ];

  home.packages = lib.mkIf config.wayland.windowManager.hyprland.enable
    (with pkgs; [
      hyprpaper

      wl-clipboard

      cliphist

      swaylock-fancy
      wofi-emoji
      pamixer

      playerctl

      # Scripts
      screenshot
    ]);
}
