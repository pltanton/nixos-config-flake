{ pkgs, osConfig, config, inputs, ... }:
let cursorSize = toString config.home.pointerCursor.size;
in {
  wayland.windowManager.hyprland = with osConfig.lib.stylix.colors; {
    plugins = [ inputs.hycov.packages.${pkgs.system}.hycov ];

    settings = {
      bind = [
        # hycov binds
        "ALT,tab,hycov:toggleoverview"
        "ALT,left,hycov:movefocus,l"
        "ALT,right,hycov:movefocus,r"
        "ALT,up,hycov:movefocus,u"
        "ALT,down,hycov:movefocus,d"
        "ALT,l,hycov:movefocus,l"
        "ALT,h,hycov:movefocus,r"
        "ALT,k,hycov:movefocus,u"
        "ALT,j,hycov:movefocus,d"
      ];

      plugin = {
        hycov = {
          enable_hotarea = 1;
          swipe_fingers = 3;
          enable_gesture = 1;
          enable_alt_release_exit = 1;
          enable_hotarea = 1; # enable mouse cursor hotarea
          hotarea_size = 10; # hotarea size in bottom left,10x10
        };
      };
    };
  };
}
