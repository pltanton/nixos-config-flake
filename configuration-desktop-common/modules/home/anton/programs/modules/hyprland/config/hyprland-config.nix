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
      ];

      env = [
        "NIXOS_OZONE_WL,1"
        "XCURSOR_SIZE,${cursorSize}"
        "QT_QPA_PLATFORMTHEME,gtk3"

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
        sensitivity = 0.65;

        touchpad = { natural_scroll = true; };
      };

      general = {
        sensitivity = 1;

        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;

        "col.active_border" = "rgb(${base07}) rgb(${base0F}) 45deg";
        "col.inactive_border" = "0xff${base03}";

        cursor_inactive_timeout = 4;
      };

      decoration = {
        rounding = 7;
        blur = { enabled = false; };
        drop_shadow = false;
        shadow_range = 8;
        shadow_render_power = 3;
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

        render_titles_in_groupbar = false;
        groupbar_titles_font_size = 12;
        groupbar_gradients = true;
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
