{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./config
    ./hyprpaper.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./targets.nix
    ./targets-config.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
  };

  programs.fish.loginShellInit = lib.mkIf config.wayland.windowManager.hyprland.enable ''
    set TTY1 (tty)
    if test -z "$DISPLAY"; and test $TTY1 = "/dev/tty1"
      exec sh -c 'Hyprland; systemctl --user stop graphical-session.target; systemctl --user stop dbus'
    end
  '';

  xdg.configFile."hypr/hyprland.conf".text = pkgs.lib.mkBefore ''
    exec=systemctl --user import-environment PATH XDG_BACKEND XDG_SESSION_TYPE XCURSOR_SIZE QT_QPA_PLATFORMTHEME
  '';
}
