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
        export XCURSOR_SIZE=${toString config.lib.base16.theme.cursorSize}
        systemctl --user import-environment PATH
        exec sh -c 'Hyprland; systemctl --user stop hyprland-session.target; systemctl --user stop graphical-session.target'
      end
    '';

  home.sessionVariables =
    lib.mkIf config.wayland.windowManager.hyprland.enable {
      GDK_PIXBUF_MODULE_FILE =
        "${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache";

      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      GDK_SCALE = 2;
      XCURSOR_SIZE = 32;

      WLR_DRM_NO_ATOMIC = "1";
      # WLR_NO_HARDWARE_

      XDG_CURRENT_DESKTOP = "hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_DATA_DIRS =
        "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:$XDG_DATA_DIRS";

      WLR_DRM_NO_MODIFIERS = 1;

      # Wayland enable
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = 1;
      _JAVA_AWT_WM_NONREPARENTING = 1;
      GDK_BACKEND = "wayland";
    };

}
