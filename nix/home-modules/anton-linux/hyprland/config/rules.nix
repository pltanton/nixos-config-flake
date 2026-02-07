_: {
  wayland.windowManager.hyprland = {
    settings = {
      workspace = [
        "r[1-4], monitor:DP-3"
        "r[1], default:true"
        "r[10], monitor:eDP-1, default:true"

        "11, defaultName:"
      ];

      layerrule = [
        "blur on, match:namespace waybar"
        "blur on, match:namespace wleave"
        # "ignorealpha 0.2, match:namespace wleave"
      ];

      windowrule = [
        "match:class ^.telegram-desktop-wrapped$, workspace 11"
        "match:title (^Slack.*$), workspace 11"
        "match:class (^firefox$), workspace 1"
        "match:class (^zen$), workspace 1"

        # telegram media viewer
        "match:class ^(.telegram-desktop-wrapped)$, match:title ^(Choose)(.*)$, float 1"
        "match:class ^(.telegram-desktop-wrapped)$, match:title ^(Choose)(.*)$, size 1100 700"
        "match:class ^(.telegram-desktop-wrapped)$, match:title ^(Choose)(.*)$, move (cursor_x-(window_w*0.5)) (cursor_y-(window_h*0.5))"
        "match:class ^(.telegram-desktop-wrapped)$, match:title ^(Choose)(.*)$, center 1"

        # firefox picture in picture float and pin
        "match:class ^(firefox)$, match:title ^(Extension: \\(fx_cast\\))(.*)$, float 1"
        "match:class ^(firefox)$, match:title ^(Picture-in-Picture)$, float 1"
        "match:class ^(firefox)$, match:title ^(Picture-in-Picture)$, pin 1"
        "match:class ^(firefox)$, match:title ^(Picture-in-Picture)$, center 1"
        "match:class ^(firefox)$, match:title ^(.*)(Sharing Indicator)$, float 1"
        # "move 0 0:^(firefox)$,title:^(.*)(Sharing Indicator)$"

        # zen picture in picture float and pin
        "match:class ^(zen)$, match:title ^(Extension: \\(fx_cast\\))(.*)$, float 1"
        "match:class ^(zen)$, match:title ^(Picture-in-Picture)$, float 1"
        "match:class ^(zen)$, match:title ^(Picture-in-Picture)$, pin 1"
        "match:class ^(zen)$, match:title ^(Picture-in-Picture)$, center 1"
        "match:class ^(zen)$, match:title ^(.*)(Sharing Indicator)$, float 1"
        # "move 0 0:^(zen)$,title:^(.*)(Sharing Indicator)$"

        # Notifications
        "match:class (swaync), animation slide"

        # Thunderbird
        "match:class thunderbird, match:initial_title Calendar Reminders, float 1"

        # Transparent terminals
        "match:class (com.mitchellh.ghostty), opacity 0.95"
        "match:class (Alacritty), opacity 0.95"

        # Float TUI utilities
        "match:class .*(impala|bluetui), float 1"
        "match:class .*(impala|bluetui), center 1"
        "match:class .*(impala|bluetui), size 900 600"

        # Idea
        "match:class (jetbrains-)(.*), match:float 1, no_initial_focus 1"

        # Floating DE elements
        "match:class ^nm-connection-editor$, float 1"
        "match:title ^Extension: (Bitwarden Password Manager).*$, float 1"
      ];
    };
  };
}
