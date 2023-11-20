{ pkgs, osConfig, config, ... }:
let cursorSize = toString config.home.pointerCursor.size;
in {
  wayland.windowManager.hyprland = with osConfig.lib.stylix.colors; {
    settings = {
      exec-once = [
        #Stores only text data
        "wl-paste --type text --watch cliphist store"
        #Stores only image data
        "wl-paste --type image --watch cliphist store"

        "hyprpaper"

        # "${pkgs.xorg.xprop}/bin/xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2"
      ];

      exec = [
        "${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme '${config.gtk.theme.name}'"
        "${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface icon-theme '${config.gtk.iconTheme.name}'"
        "${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface cursor-theme '${config.home.pointerCursor.name}'"
        "${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface cursor-size ${cursorSize}"
        "${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface text-scaling-factor 1.0"
        "${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface font-name 'Inter 11'"
        "${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface scaling-factor 1"
        "${pkgs.glib}/bin/gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:'"
      ];

      env = [
        "NIXOS_OZONE_WL,1"
        "XCURSOR_SIZE,${cursorSize}"
        "QT_QPA_PLATFORMTHEME,gtk3"
        "ANKI_WAYLAND,1"

        # "GDK_SCALE,2"
        # "QT_ENABLE_HIGHDPI_SCALING,1"
        # "QT_SCALE_FACTOR,2"

        "WLR_DRM_NO_ATOMIC,1"
        "XDG_DATA_DIRS,${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:$XDG_DATA_DIRS"
        "WLR_DRM_NO_MODIFIERS,1"
        "SDL_VIDEODRIVER,wayland"
        "_JAVA_AWT_WM_NONREPARENTING,1"
      ];

      input = {
        kb_layout = "us,ru";
        kb_variant = "dvorak,";
        kb_model = "";
        kb_options = "grp:caps_toggle";
        kb_rules = "";
        repeat_rate = 40;
        follow_mouse = 1;
        float_switch_override_focus = 0;
        sensitivity = 0.65;

        touchpad = { natural_scroll = true; };
      };

      general = {
        sensitivity = 1;

        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;

        cursor_inactive_timeout = 4;
      };

      decoration = {
        rounding = 6;
        blur = { enabled = false; };
        drop_shadow = true;
        shadow_range = 8;
        shadow_render_power = 2;
        dim_inactive = false;
        dim_strength = 0.2;
      };

      animations = {
        enabled = 1;
        animation = [
          "workspaces,1,1,default,slide"
          "fade,1,7,default"
          "windowsMove,0,7,default"
        ];
      };

      dwindle = {
        pseudotile = 0; # enable pseudotiling on dwindle
        preserve_split = true;
        no_gaps_when_only = 1;
      };

      misc = {
        enable_swallow = true;
        swallow_regex = "^(Alacritty)$";
        mouse_move_enables_dpms = true;
        disable_autoreload = true;
        focus_on_activate = true;

      };

      group = {
        groupbar = {
          render_titles = false;
          gradients = false;
          "col.active" = "rgb(${base07}) rgb(${base0F}) 45deg";
          "col.inactive" = "0xff${base03}";
          "col.locked_active" = "rgb(${base07}) rgb(${base0F}) 45deg";
          "col.locked_inactive" = "0xff${base03}";
        };
      };

      binds = { workspace_back_and_forth = true; };

      xwayland = {
        use_nearest_neighbor = false;
        force_zero_scaling = false;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_create_new = false;
      };
    };
  };
}
