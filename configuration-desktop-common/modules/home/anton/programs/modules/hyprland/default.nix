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
    xwayland.enable = true;
    xwayland.hidpi = true;
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

  home.sessionVariables = with config.lib.base16.theme;
    lib.mkIf config.wayland.windowManager.hyprland.enable {
      # GDK_SCALE = "2";
      # QT_SCALE_FACTOR = "2";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      # XCURSOR_SIZE = 64;
      # XCURSOR_SIZE =
      #   lib.mkForce (toString config.lib.base16.theme.cursorSizeX2);

      WLR_DRM_NO_ATOMIC = "1";
      XDG_DATA_DIRS =
        "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:$XDG_DATA_DIRS";

      WLR_DRM_NO_MODIFIERS = 1;

      GTK_USE_PORTAL = 1;
      SDL_VIDEODRIVER = "wayland";

      XDG_CURRENT_DESKTOP = "gnome";
    };

  # xresources = lib.mkIf config.wayland.windowManager.hyprland.enable {
  #   properties = {
  #     "*dpi" = "192";
  #     "Xft.dpi" = "192";
  #     "Xcursor.size" =
  #       lib.mkForce (toString config.lib.base16.theme.cursorSizeX2);
  #   };
  # };

  xdg.configFile."hypr/hyprland.conf".text = (pkgs.lib.mkBefore ''
    exec=systemctl --user import-environment PATH XDG_BACKEND XDG_SESSION_TYPE XCURSOR_SIZE
  '');

}
