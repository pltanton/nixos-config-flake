{ config, lib, pkgs, inputs, ... }:
let scripts = import ./scripts pkgs config;
in {
  home.packages = lib.mkIf config.wayland.windowManager.hyprland.enable
    (with pkgs; [
      hyprpaper

      wl-clipboard
      swayidle
      clipman

      # For screenshots
      grim
      slurp
      swappy

      swaylock-fancy

      wofi-emoji
    ]);

  wayland.windowManager.hyprland = let
    grabScreenshot = pkgs.writeShellScript "grabScreenshot" ''
      mkdir -p ~/Screenshots
      FILE_PATH=~/Screenshots/shot_$(date +"%y%m%d%H%M%S").png
      grim -g "$(slurp)" - | swappy -f - -o "$FILE_PATH"
      wl-copy -t image/png < $FILE_PATH
    '';
  in with config.lib.base16.theme; {
    extraConfig = ''
      # This is an example Hyprland config file.
      # Syntax is the same as in Hypr, but settings might differ.
      #
      # Refer to the wiki for more information.
      exec-once=xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2

      exec-once=hyperctl setcursor ${cursorTheme} ${toString cursorSize}
      exec-once=${pkgs.glib}/bin/gsettings set $gnome-schema gtk-theme '${gtkTheme}'
      exec-once=${pkgs.glib}/bin/gsettings set $gnome-schema icon-theme '${iconTheme}'
      exec-once=${pkgs.glib}/bin/gsettings set $gnome-schema cursor-theme '${cursorTheme}'
      exec-once=${pkgs.glib}/bin/gsettings set $gnome-schema cursor-size '${
        toString cursorSize
      }'
      exec-once=${pkgs.glib}/bin/gsettings set $gnome-schema text-scaling-factor 1.2
      exec-once=${pkgs.glib}/bin/gsettings set $gnome-schema font-name '${fontUIName} 11'

      # exec-once=systemctl --user start eww swayidle
      # exec-once=swaybg -i ~/.config/wallpaper.png
      exec-once=hyprpaper


      monitor=DP-1,3840x2160@59.997,0x0,1
      monitor=eDP-1,3840x2160%60.000,3840x888,1.7
      workspace=DP-1,1
      workspace=eDP-1,10


      input {
          kb_layout=us,ru
          kb_variant=dvorak,
          kb_model=
          kb_options=grp:caps_toggle
          kb_rules=

          follow_mouse=1
      }

      general {
          sensitivity=1
          main_mod=SUPER

          gaps_in=5
          gaps_out=10
          border_size=4
          col.active_border=0xff${base0D-hex}
          col.inactive_border=0xff${base03-hex}

          damage_tracking=full # leave it on full unless you hate your GPU and want to make it suffer

          cursor_inactive_timeout=4
      }

      decoration {
          rounding=0
          blur_size=8 # minimum 1
          blur_passes=1 # minimum 1, more passes = more resource intensive.
          # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
          # if you want heavy blur, you need to up the blur_passes.
          # the more passes, the more you can up the blur_size without noticing artifacts.
          blur=true
          blur_new_optimizations = true
          drop_shadow = false
      }

      animations {
          animation=workspaces,1,100,default
          animation=windows,1,100,default,popin 80%
          animation=fade,1,10,default
      }

      dwindle {
          pseudotile=0 # enable pseudotiling on dwindle
      }

      animations {
          enabled=1
          animation=windows,1,7,default
          animation=border,1,10,default
          animation=fade,1,10,default
          animation=workspaces,1,6,default
      }

      misc {
          no_vfr = false # should improve battery concuption and performance
      }


      # Rofi bindings
      bind=SUPERSHIFT,v,exec,clipman pick -t rofi
      bind=SUPER,v,exec,rofi-vpn
      bind=SUPERSHIFT,e,exec,rofi -show emoji -modi emoji
      bind=SUPER,Return,exec,rofi -show drun -show-icons
      bind=SUPERSHIFT,l,exec,lock

      bind=,Print,exec,${grabScreenshot}
      bind=SUPERSHIFT,Return,exec,alacritty

      bind=SUPERSHIFT,Q,exit,

      # Manipulate with active window state
      bind=SUPERSHIFT,C,killactive,
      bind=SUPERSHIFT,Space,togglefloating,
      bind=SUPER,P,pseudo,
      bind=SUPER,F,fullscreen,

      # Move through windows
      bind=SUPER,left,movefocus,l
      bind=SUPER,right,movefocus,r
      bind=SUPER,up,movefocus,u
      bind=SUPER,down,movefocus,d
      bind=SUPERSHIFT,left,movewindow,l
      bind=SUPERSHIFT,right,movewindow,r
      bind=SUPERSHIFT,up,movewindow,u
      bind=SUPERSHIFT,down,movewindow,d

      # Moving through monitors
      bind=SUPER,apostrophe,focusmonitor,l
      bind=SUPER,comma,focusmonitor,r
      bind=SUPERSHIFT,apostrophe,movecurrentworkspacetomonitor,l
      bind=SUPERSHIFT,comma,movecurrentworkspacetomonitor,r

      # Moving through workspaces
      bind=SUPER,1,workspace,1
      bind=SUPER,2,workspace,2
      bind=SUPER,3,workspace,3
      bind=SUPER,4,workspace,4
      bind=SUPER,5,workspace,5
      bind=SUPER,6,workspace,6
      bind=SUPER,7,workspace,7
      bind=SUPER,8,workspace,8
      bind=SUPER,9,workspace,9
      bind=SUPER,tab,workspace,10
      bind=SUPERSHIFT,1,movetoworkspace,1
      bind=SUPERSHIFT,2,movetoworkspace,2
      bind=SUPERSHIFT,3,movetoworkspace,3
      bind=SUPERSHIFT,4,movetoworkspace,4
      bind=SUPERSHIFT,5,movetoworkspace,5
      bind=SUPERSHIFT,6,movetoworkspace,6
      bind=SUPERSHIFT,7,movetoworkspace,7
      bind=SUPERSHIFT,8,movetoworkspace,8
      bind=SUPERSHIFT,9,movetoworkspace,9
      bind=SUPERSHIFT,tab,movetoworkspace,10

      # WOB
      bind=,XF86AudioRaiseVolume,exec,${pkgs.pamixer}/bin/pamixer --get-volume -ui 5 > $WOBSOCK
      bind=,XF86AudioLowerVolume,exec,${pkgs.pamixer}/bin/pamixer --get-volume -ud 5 > $WOBSOCK
      bind=,XF86AudioMute,exec,${pkgs.pamixer}/bin/pamixer --toggle-mute && ((${pkgs.pamixer}/bin/pamixer --get-mute && echo 0) || ${pkgs.pamixer}/bin/pamixer --get-volume) | tail -n 1 > $WOBSOCK
      bind=,XF86MonBrightnessUp,exec,${scripts}/bin/brightness --inc -d 5 | head -n 1 > $WOBSOCK
      bind=,XF86MonBrightnessDown,exec,${scripts}/bin/brightness --dec -d 5 | head -n 1 > $WOBSOCK

      # Window rules
      windowrule=workspace 10,^telegramdesktop$
      windowrule=workspace 10,title:^Slack.*$
      windowrule=opacity 0.9,^Alacritty$
      windowrule=opacity 0.9,^emacs$
      windowrule=workspace 2,^emacs$
      windowrule=workspace 1,^firefox$

      # Resize submap
      bind=SUPER,R,submap,resize
      submap=resize

      binde=,right,resizeactive,10 0
      binde=,left,resizeactive,-10 0
      binde=,up,resizeactive,0 -10
      binde=,down,resizeactive,0 10
      bind=,escape,submap,reset

      submap=reset

      # Notification submap
      bind=SUPER,N,submap,mako
      submap=mako

      bind=SHIFT,d,exec,makoctl dismis --all; hyprctl dispatch submap reset
      bind=,Return,exec,makoctl invoke; makoctl dismiss; hyprctl dispatch submap reset
      bind=,d,exec,makoctl dismiss
      bind=,escape,submap,reset

      submap=reset


      exec-once=telegram-desktop
      exec-once=slack
      exec-once=emacs


    '';
  };
}
