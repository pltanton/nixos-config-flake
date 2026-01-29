_: {
  wayland.windowManager.hyprland = {
    extraConfig = ''
      source=${./hyprland-overrides.conf}
      source = ~/.config/hypr/monitors.conf
    '';
    settings = {
      bindl = [
        # ", switch:on:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, disable\""
        # ", switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, 3840x2400, 0x0, 2\""
      ];

    };
  };
}
