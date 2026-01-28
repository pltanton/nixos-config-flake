{
  pkgs,
  lib,
  ...
}: let
  directions = rec {
    left = "l";
    right = "r";
    up = "u";
    down = "d";
    h = left;
    j = down;
    k = up;
    l = right;
  };
  buildWorkspace = key: id: {
    inherit key;
    inherit id;
  };
  buildWorkspaceDefault = key: buildWorkspace key key;
  workspaces = [
    (buildWorkspaceDefault "1")
    (buildWorkspaceDefault "2")
    (buildWorkspaceDefault "3")
    (buildWorkspaceDefault "4")
    (buildWorkspaceDefault "5")
    (buildWorkspaceDefault "6")
    (buildWorkspaceDefault "7")
    (buildWorkspaceDefault "8")
    (buildWorkspaceDefault "9")
    (buildWorkspace "0" "10")
    (buildWorkspace "tab" "11")

    (buildWorkspace "b" "1") # browser
    (buildWorkspace "e" "3") # editor
    (buildWorkspace "t" "3") # terminal
    (buildWorkspace "i" "4") # ide
  ];
in {
  wayland.windowManager.hyprland = {
    settings = {
      bind = lib.flatten [
        # Rofi keybinds
        "SUPERSHIFT,v,exec,cliphist list | uwsm app -- rofi -modi clipboard:${pkgs.cliphist}/bin/cliphist-rofi-img -show clipboard -show-icons -p "
        "SUPERSHIFT,e,exec,uwsm app -- rofi -show emoji -modi emoji"
        "SUPER,Return,exec,uwsm app -- rofi -show drun"

        # "SUPERSHIFT,v,exec,cliphist list | uwsm app -- walker -m clipboard"
        # "SUPERSHIFT,e,exec,uwsm app -- walker -m emojis"
        # "SUPER,Return,exec,uwsm app -- walker"

        "SUPER,f12,exec,loginctl lock-session"
        ",Print,exec,uwsm app -- screenshot"
        "SHIFT,Print,exec,uwsm app -- screenshot -e"
        # "SUPERSHIFT,Return,exec,uwsm app -- alacritty"
        "SUPERSHIFT,Return,exec,uwsm app -- ghostty"
        "SUPERSHIFT,Q,exec,uwsm stop"

        # Manipulate with active window state
        "SUPERSHIFT,C,killactive,"
        "SUPERSHIFT,F,togglefloating,"
        "SUPER,F,fullscreen,"
        "SUPERSHIFT,P,pin,"

        # "SUPER,v,hy3:makegroup,v,ephemeral"
        # "SUPER,w,hy3:makegroup,h,ephemeral"
        # "SUPER,x,hy3:changegroup,opposite"

        # "SUPER,v,preselect,v"
        # "SUPER,w,preselect,h"
        "SUPER,x,layoutmsg,togglesplit"
        "SUPERSHIFT,x,layoutmsg,swapsplit"

        (lib.mapAttrsToList (key: direction: "SUPERALT,${key},moveintogroup,${direction},visible") directions)

        # Groups aka tabs
        # "SUPER,g,hy3:changegroup,toggletab"
        # "SUPERSIFT,g,hy3:changefocus,tab"

        "SUPER,g,togglegroup"
        "SUPER,p,changegroupactive,b"
        "SUPER,n,changegroupactive,f"

        # Move through windows
        (lib.mapAttrsToList (key: direction: "SUPER,${key},movefocus,${direction}") directions)
        (lib.mapAttrsToList (key: direction: "SUPERSHIFT,${key},movewindow,${direction}") directions)
        # (lib.mapAttrsToList (key: direction: "SUPER,${key},hy3:movefocus,${direction},visible") directions)
        # (lib.mapAttrsToList (key: direction: "SUPERSHIFT,${key},hy3:movewindow,${direction},visible") directions)
        # "SUPER,p,hy3:focustab,l,,wrap"
        # "SUPER,n,hy3:focustab,r,,wrap"
        # "SUPER,u,hy3:changefocus,raise"
        # "SUPER,d,hy3:changefocus,down"

        # Moving through monitors
        "SUPER,apostrophe,focusmonitor,l"
        "SUPER,comma,focusmonitor,r"
        "SUPERSHIFT,apostrophe,movecurrentworkspacetomonitor,l"
        "SUPERSHIFT,comma,movecurrentworkspacetomonitor,r"

        # Moving through workspaces
        (map (n: "SUPER,${n.key},workspace,${n.id}") workspaces)
        # (map (n: "SUPERSHIFT,${n.key},hy3:movetoworkspace,${n.id},follow") workspaces)
        (map (n: "SUPERSHIFT,${n.key},movetoworkspace,${n.id}") workspaces)

        # Media keys
        ",XF86AudioPlay,exec,playerctl play-pause"
        ",XF86AudioStop,exec,playerctl pause"
        ",XF86AudioNext,exec,playerctl next"
        ",XF86AudioPrev,exec,playerctl previous"

        # Keyboard layout switch
        "SUPERSHIFT,Space,exec,hyprctl switchxkblayout current 2"
        "SUPER,Space,exec,xkb-smart-switch"
      ];

      bindel = [
        # Media keys

        # ",XF86AudioRaiseVolume,exec,wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
        # ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        # ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        # ",XF86AudioMicMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86AudioRaiseVolume,exec,swayosd-client --output-volume raise"
        ",XF86AudioLowerVolume,exec,swayosd-client --output-volume lower"
        ",XF86AudioMute,exec,swayosd-client --output-volume mute-toggle"
        ",XF86AudioMicMute,exec,volumectl -m toggle-mute"
      ];

      binde = [
        # Media keys

        # ",XF86MonBrightnessUp,exec,light -A 5"
        # ",XF86MonBrightnessDown,exec,light -U 5"
        ",XF86MonBrightnessUp,exec,swayosd-client --brightness raise"
        ",XF86MonBrightnessDown,exec,swayosd-client --brightness lower"
      ];

      # Mouse bindings
      bindm = ["SUPER,mouse:272,movewindow" "SUPER,mouse:273,resizewindow"];

      # bindn = [
      #   ",mouse:272,hy3:focustab,mouse"
      # ];
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
