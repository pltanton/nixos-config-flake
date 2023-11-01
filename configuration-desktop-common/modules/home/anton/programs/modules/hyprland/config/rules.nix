{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        "workspace 10,^org.telegram.desktop$"
        "workspace 10,title:^Slack.*$"
        "workspace 1,^firefox$"
      ];

      windowrulev2 = [
        # telegram media viewer
        "float,class:^(telegramdesktop)$,title:^(Media viewer)$"
        "float,class:^(.telegram-desktop-wrapped)$,title:^(Choose)(.*)$"
        "size 1100 700,class:^(.telegram-desktop-wrapped)$,title:^(Choose)(.*)$"
        "center,class:^(.telegram-desktop-wrapped)$,title:^(Choose)(.*)$"

        # firefox picture in picture float and pin
        "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "pin,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "center,class:^(firefox)$,title:^(Picture-in-Picture)$"

        "float,class:^(firefox)$,title:^(.*)(Sharing Indicator)$"
        "move 0 0:^(firefox)$,title:^(.*)(Sharing Indicator)$"

        # # Jetbrains products
        "noanim,class:^(jetbrains-.*)"
        "float,floating:0,class:^(jetbrains-.*),title:^(win.*)"
        "noinitialfocus,class:^(jetbrains-.*),title:^(win.*)"
        "float,class:^(jetbrains-.*),title:^(Welcome to.*)"
        # "float,floating:0,class:^(jetbrains-.*),title:^(?!win.*)"
        # "forceinput,class:^(jetbrains-.*)"
        # "stayfocused,class:^(jetbrains-.*),title:^(?!win.*)"
        "windowdance,class:^(jetbrains-.*)" # allows IDE to move child windows
      ];
    };
  };
}
