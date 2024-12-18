{pkgs, ...}: {
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        # Rofi keybinds
        "SUPERSHIFT,v,exec,cliphist list | uwsm app -- rofi -modi clipboard:${pkgs.cliphist}/bin/cliphist-rofi-img -show clipboard -show-icons -p "
        "SUPERSHIFT,e,exec,uwsm app -- rofi -show emoji -modi emoji"
        "SUPER,Return,exec,uwsm app -- rofi -show drun -show-icons"

        "SUPER,f12,exec,loginctl lock-session"
        ",Print,exec,uwsm app -- screenshot"
        "SHIFT,Print,exec,uwsm app -- screenshot -e"
        "SUPERSHIFT,Return,exec,uwsm app -- alacritty"
        "SUPERSHIFT,Q,exec,loginctl terminate-user ''"

        # Manipulate with active window state
        "SUPERSHIFT,C,killactive,"
        "SUPERSHIFT,Space,togglefloating,"
        "SUPER,F,fullscreen,"
        "SUPERSHIFT,P,pin,"

        "SUPER,v,togglesplit,"

        # Move through windows
        "SUPER,h,movefocus,l"
        "SUPER,left,movefocus,l"
        "SUPER,l,movefocus,r"
        "SUPER,right,movefocus,r"
        "SUPER,k,movefocus,u"
        "SUPER,up,movefocus,u"
        "SUPER,j,movefocus,d"
        "SUPER,down,movefocus,d"
        "SUPERSHIFT,h,movewindow,l"
        "SUPERSHIFT,l,movewindow,r"
        "SUPERSHIFT,k,movewindow,u"
        "SUPERSHIFT,j,movewindow,d"

        "SUPER,w,togglegroup,"
        "SUPERSHIFT,w,moveoutofgroup,"
        "SUPER,n,changegroupactive,f"
        "SUPER,p,changegroupactive,b"

        "SUPER_CONTROL,h,moveintogroup,l"
        "SUPER_CONTROL,l,moveintogroup,r"
        "SUPER_CONTROL,k,moveintogroup,u"
        "SUPER_CONTROL,j,moveintogroup,d"

        # Moving through monitors
        "SUPER,apostrophe,focusmonitor,l"
        "SUPER,comma,focusmonitor,r"
        "SUPERSHIFT,apostrophe,movecurrentworkspacetomonitor,l"
        "SUPERSHIFT,comma,movecurrentworkspacetomonitor,r"

        # Moving through workspaces
        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"
        "SUPER,6,workspace,6"
        "SUPER,7,workspace,7"
        "SUPER,8,workspace,8"
        "SUPER,9,workspace,9"
        "SUPER,0,workspace,10"
        "SUPER,tab,workspace,10"
        "SUPERSHIFT,1,movetoworkspace,1"
        "SUPERSHIFT,2,movetoworkspace,2"
        "SUPERSHIFT,3,movetoworkspace,3"
        "SUPERSHIFT,4,movetoworkspace,4"
        "SUPERSHIFT,5,movetoworkspace,5"
        "SUPERSHIFT,6,movetoworkspace,6"
        "SUPERSHIFT,7,movetoworkspace,7"
        "SUPERSHIFT,8,movetoworkspace,8"
        "SUPERSHIFT,9,movetoworkspace,9"
        "SUPERSHIFT,0,movetoworkspace,10"
        "SUPERSHIFT,tab,movetoworkspace,10"

        # Media keys
        ",XF86AudioPlay,exec,playerctl play-pause"
        ",XF86AudioStop,exec,playerctl pause"
        ",XF86AudioNext,exec,playerctl next"
        ",XF86AudioPrev,exec,playerctl previous"

        # Keyboard layout switch
        "SUPER,Space,exec,xkb-smart-switch"
        "SUPER,g,exec,hyprctl switchxkblayout current 2"
      ];

      bindel = [
        # Media keys

        ",XF86AudioRaiseVolume,exec,swayosd-client --output-volume raise"
        ",XF86AudioLowerVolume,exec,swayosd-client --output-volume lower"
        ",XF86AudioMute,exec,swayosd-client --output-volume mute-toggle"
        ",XF86AudioMicMute,exec,volumectl -m toggle-mute"
      ];

      binde = [
        # Media keys

        ",XF86MonBrightnessUp,exec,swayosd-client --brightness raise"
        ",XF86MonBrightnessDown,exec,swayosd-client --brightness lower"
      ];

      # Mouse bindings
      bindm = ["SUPER,mouse:272,movewindow" "SUPER,mouse:273,resizewindow"];
    };

    extraConfig = ''
      # Submaps

      # Resize submap
      bind=SUPER,R,submap,resize
      submap=resize

      binde=,right,resizeactive,10 0
      binde=,l,resizeactive,10 0
      binde=,left,resizeactive,-10 0
      binde=,h,resizeactive,-10 0
      binde=,up,resizeactive,0 -10
      binde=,k,resizeactive,0 10
      binde=,down,resizeactive,0 10
      binde=,j,resizeactive,0 10
      bind=,escape,submap,reset

      submap=reset

      # Notification submap
      bind=SUPERSHIFT,N,submap,notifications
      submap=notifications
      bind=,escape,submap,reset

      # toggle panel
      bind=,n,exec,swaync-client -t
      # toggle DND
      bind=,d,exec,swaync-client -d
      bind=,d,submap,reset
      # clear all notifications
      bind=shift,c,exec,swaync-client --close-all
      bind=shift,c,submap,reset
      # clear latest notification

      submap=reset
    '';
  };
}
