{ config, lib, pkgs, inputs, ... }: {
  imports = [
    ./config
    ./hyprpaper.nix
    ./swayidle.nix
    ./targets.nix
    ./targets-config.nix
    # ./desktop-items-overrides.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    # package = pkgs.hyprland-hidpi;

    xwayland = {
      enable = true;
      hidpi = true;
    };

    recommendedEnvironment = true;
    systemdIntegration = true;
  };

  # home.packages = [ (pkgs.hiPrio pkgs.unstable.xwayland) ];

  programs.fish.loginShellInit =
    lib.mkIf config.wayland.windowManager.hyprland.enable ''
      set TTY1 (tty)
      if test -z "$DISPLAY"; and test $TTY1 = "/dev/tty1"
        exec sh -c 'Hyprland; systemctl --user stop hyprland-session.target; systemctl --user stop graphical-session.target'
      end
    '';

  xdg.configFile."hypr/hyprland.conf".text = (pkgs.lib.mkBefore ''
    exec=systemctl --user import-environment PATH XDG_BACKEND XDG_SESSION_TYPE XCURSOR_SIZE
  '');

}
