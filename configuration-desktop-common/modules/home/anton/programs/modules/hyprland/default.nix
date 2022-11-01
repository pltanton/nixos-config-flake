{ config, lib, pkgs, inputs, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./config
    ./hyprpaper.nix
    ./swayidle.nix
    ./targets.nix
    ./targets-config.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    xwayland.hidpi = true;
  };

  # home.packages = [ (pkgs.hiPrio pkgs.unstable.xwayland) ];

  programs.fish.loginShellInit =
    lib.mkIf config.wayland.windowManager.hyprland.enable ''
      set TTY1 (tty)
      if test -z "$DISPLAY"; and test $TTY1 = "/dev/tty1"
        systemctl --user import-environment PATH
        exec sh -c 'Hyprland; systemctl --user stop hyprland-session.target; systemctl --user stop graphical-session.target'
        # exec sh -c 'Hyprland > hyprland.log 2>&1; systemctl --user stop hyprland-session.target; systemctl --user stop graphical-session.target'
      end
    '';

  home.sessionVariables =
    lib.mkIf config.wayland.windowManager.hyprland.enable {
      WLR_DRM_NO_ATOMIC = "1";
      XDG_DATA_DIRS =
        "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:$XDG_DATA_DIRS";

      WLR_DRM_NO_MODIFIERS = 1;

      GTK_USE_PORTAL = 1;
      SDL_VIDEODRIVER = "wayland";

      XDG_CURRENT_DESKTOP = "gnome";
    };
}
