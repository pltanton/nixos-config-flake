_: {
  wayland.windowManager.hyprland = {
    settings = {
      workspace = [
        "r[1-4], monitor:DP-3"
        "r[1], default:true"
        "r[10], monitor:eDP-1, default:true"

        "11, defaultName:"
      ];

      windowrulev2 = [
        "workspace 11,class:^(.telegram-desktop-wrapped)$"
        "workspace 11,title:(^Slack.*$)"
        "workspace 1,class:(^firefox$)"

        # telegram media viewer
        "float,class:^(.telegram-desktop-wrapped)$,title:^(Choose)(.*)$"
        "size 1100 700,class:^(.telegram-desktop-wrapped)$,title:^(Choose)(.*)$"
        "move onscreen cursor 50% 50%,class:^(.telegram-desktop-wrapped)$,title:^(Choose)(.*)$"
        "center,class:^(.telegram-desktop-wrapped)$,title:^(Choose)(.*)$"

        # firefox picture in picture float and pin
        "float,class:^(firefox)$,title:^(Extension: \(fx_cast\))(.*)$"
        "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "pin,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "center,class:^(firefox)$,title:^(Picture-in-Picture)$"

        "float,class:^(firefox)$,title:^(.*)(Sharing Indicator)$"
        "move 0 0:^(firefox)$,title:^(.*)(Sharing Indicator)$"

        "animation slide, class:(swaync)"

        "opacity 0.9,class:(com.mitchellh.ghostty)"
        "opacity 0.9,class:(Alacritty)"
      ];

      layerrule = [
        "blur,swaync-control-center"
        "ignorezero,swaync-control-center"
      ];
    };
  };
}
