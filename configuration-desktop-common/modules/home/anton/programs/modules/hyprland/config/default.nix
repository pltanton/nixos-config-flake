{ osConfig, config, lib, pkgs, inputs, ... }: {

  imports = [ ./keybinds.nix ./hyprland-config.nix ./rules.nix ./plugins.nix ];

  wayland.windowManager.hyprland = {
    # package = null;
    enable = true;
  };

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

      # Hyprcursor cursor
      (pkgs.runCommand "moveUp" { } ''
        mkdir -p $out/share/icons
        ln -s ${inputs.rose-pine-hyprcursor} $out/share/icons/rose-pine-hyprcursor
      '')
    ]);

}
