{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./scripts
    ./config
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./targets.nix
    ./targets-config.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    xwayland.enable = true;

    systemd.enable = false; # since it conflicts with uwsm

    plugins = with pkgs.hyprlandPlugins; [
      # hypr-dynamic-cursors
      # hyprexpo
      # hyprspace
    ];
  };

  programs.fish.loginShellInit = lib.mkIf config.wayland.windowManager.hyprland.enable ''
    if uwsm check may-start
      exec uwsm start hyprland-uwsm.desktop
    end
  '';

  # xdg.configFile."hypr/hyprland.conf".text = pkgs.lib.mkBefore ''
  #   exec=systemctl --user import-environment PATH XDG_BACKEND XDG_SESSION_TYPE XCURSOR_SIZE QT_QPA_PLATFORMTHEME
  # '';
}
