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
        "size 1100 700,class:^(telegramdesktop)$,title:^(Choose)(.*)$"
        "center,class:^(telegramdesktop)$,title:^(Choose)(.*)$"

        # firefox picture in picture float and pin
        "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "pin,class:^(firefox)$,title:^(Picture-in-Picture)$"
        "center,class:^(firefox)$,title:^(Picture-in-Picture)$"

        "float,class:^(firefox)$,title:^(.*)(Sharing Indicator)$"
        "move 0 0:^(firefox)$,title:^(.*)(Sharing Indicator)$"

        # Jetbrains products
        "forceinput,class:^(jetbrains-.*)$,title:^(?!(win)).*$"
        "windowdance,class:^(jetbrains-.*)$"
        "size 60% 80%,class:^(jetbrains-.*)$,floating:1,title:$ ^"
        "center,class:^(jetbrains-.*)$,floating:1,title:$ ^"
        "center,class:^(jetbrains-.*)$,floating:1,title:$ ^Open Project"

      ];
    };
  };
}
