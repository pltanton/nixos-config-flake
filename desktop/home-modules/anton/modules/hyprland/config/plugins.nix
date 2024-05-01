{ pkgs, osConfig, config, inputs, ... }:
let cursorSize = toString config.home.pointerCursor.size;
in {
  wayland.windowManager.hyprland = with osConfig.lib.stylix.colors; {
    # plugins = [ inputs.hycov.packages.${pkgs.system}.hycov ];

    # extraConfig = ''
    #   plugin {
    #       hycov {
    #         overview_gappo = 60 #gaps width from screen
    #         overview_gappi = 24 #gaps width from clients
    #         enable_hotarea = 0 # enable mouse cursor hotarea
    #         enable_alt_release_exit = 1
    #         swipe_fingers = 4
    #         enable_gesture = 1
    #       }
    #   }
    # '';

    settings = {
      bind = [
        # hycov binds
        # "ALT,tab,hycov:toggleoverview"
        # "ALT,left,hycov:movefocus,l"
        # "ALT,right,hycov:movefocus,r"
        # "ALT,up,hycov:movefocus,u"
        # "ALT,down,hycov:movefocus,d"
        # "ALT,h,hycov:movefocus,l"
        # "ALT,l,hycov:movefocus,r"
        # "ALT,k,hycov:movefocus,u"
        # "ALT,j,hycov:movefocus,d"
      ];
    };
  };
}
