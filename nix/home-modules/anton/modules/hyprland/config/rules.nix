{...}: {
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        "workspace 10,^org.telegram.desktop$"
        "workspace 10,title:^Slack.*$"
        "workspace 1,^firefox$"
      ];

      windowrulev2 = [
        # telegram media viewer
        # "float,class:^(telegramdesktop)$,title:^(Media viewer)$"
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

        # Jetbrains xwayland fixes
        # "stayfocused,class:^(jetbrains-.*),floating:0,xwayland:1"
        # "center,class:^(jetbrains-.*)$,floating:1,xwayland:1"
        "dimaround,class:^(jetbrains-.*)$,floating:1,title:^(?!win),xwayland:1"
        # "center,class:^(jetbrains-.*)$,floating:1,title:^(?!win),xwayland:1"
        "noanim,class:^(jetbrains-.*)$,title:^(win.*),xwayland:1$"
        "noinitialfocus,class:^(jetbrains-.*)$,title:^(win.*),xwayland:1$"

        # Swaync do not focus
        "animation slide, class:(swaync)"

        "opacity 0.9,class:(Alacritty),focus:0$"
      ];

      layerrule = [
        "blur,swaync-control-center"
        "ignorezero,swaync-control-center"
      ];
    };
  };
}
