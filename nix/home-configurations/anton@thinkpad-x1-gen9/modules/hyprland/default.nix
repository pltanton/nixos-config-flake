_: {
  wayland.windowManager.hyprland = {
    extraConfig = "source=${./hyprland-overrides.conf}";
    settings = {
      bindl = [
        ", switch:on:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, disable\""
        ", switch:off:Lid Switch, exec, hyprctl keyword monitor \"eDP-1, 3840x2400, 0x0, 1\""
      ];

      monitor = [
        "eDP-1, 3840x2400@60.00Hz, 0x0, 1"
        "desc:Dell Inc. DELL U2723QE JSJ91P3, preffered, -3200x-600, 1.2"
        ", preffered, auto, 1"
      ];
    };
  };
}
