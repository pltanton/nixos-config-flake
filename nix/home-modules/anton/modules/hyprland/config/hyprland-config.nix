{
  pkgs,
  config,
  ...
}: let
  inherit (config.lib.stylix) colors;
in {
  xdg.configFile = {
    "uwsm/env".text = ''
      export NIXOS_OZONE_WL=1
      export GDK_BACKEND=wayland,x11
      export GTK_USE_PORTAL=1
      export QT_QPA_PLATFORM=wayland;xcb
      export QT_QPA_PLATFORMTHEME=gtk3
      export QT_AUTO_SCREEN_SCALE_FACTOR=1
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export SDL_VIDEODRIVER=wayland
      export ANKI_WAYLAND=1
      export XCURSOR_SIZE=${toString config.stylix.cursor.size}
      export XCURSOR_THEME=${config.stylix.cursor.name}
    '';
  };

  wayland.windowManager.hyprland.settings = {
    monitor = [
      ",preferred,auto,1,bitdepth,8"
    ];

    exec = [
      "${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface gtk-theme '${config.gtk.theme.name}'"
      "${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface icon-theme '${config.gtk.iconTheme.name}'"
      "${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface cursor-theme '${config.home.pointerCursor.name}'"
      "${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface text-scaling-factor 1.0"
      "${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface font-name 'Inter 11'"
      "${pkgs.glib}/bin/gsettings set org.gnome.desktop.interface scaling-factor 1"
      "${pkgs.glib}/bin/gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:'"
    ];

    input = {
      kb_layout = "us,ru,gr-dvorak";
      kb_variant = "dvorak,,";
      # Deprecated in favour of smart switch script
      # kb_options = "grp:win_space_toggle";
      repeat_rate = 40;
      float_switch_override_focus = 0;
      sensitivity = 1;

      touchpad = {natural_scroll = true;};
    };

    general = {
      gaps_in = 4;
      gaps_out = 6;
      border_size = 2;
      layout = "hy3";
      # gaps_workspaces = 100;

      # "col.active_border" = "rgb(${colors.base0E}) rgb(${colors.base0D}) 45deg";
      # "col.inactive_border" = "rgb(${colors.base02})";
      "col.active_border" = "$teal $sapphire 45deg";
      "col.inactive_border" = "$surface2";
    };

    decoration = {
      rounding = 10;
      blur = {enabled = false;};

      # drop_shadow = true;
      # shadow_range = 3;
      # shadow_render_power = 1;

      dim_inactive = false;
      dim_strength = 0.2;
    };

    animations = {
      enabled = 1;
      bezier = [
        "md3_standard, 0.2, 0, 0, 1"
        "md3_decel, 0.05, 0.7, 0.1, 1"
        "md3_accel, 0.3, 0, 0.8, 0.15"
        "overshot, 0.05, 0.9, 0.1, 1.1"
        "crazyshot, 0.1, 1.5, 0.76, 0.92"
        "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
        "fluent_decel, 0.1, 1, 0, 1"
        "easeInOutCirc, 0.85, 0, 0.15, 1"
        "easeOutCirc, 0, 0.55, 0.45, 1"
        "myBezier, 0.05, 0.9, 0.1, 1.05"
      ];
      animation = [
        "windows, 1, 4, default, popin 80%"
        "border, 1, 10, default"
        "fade, 1, 2, default"
        "workspaces, 1, 2, md3_decel, slide"
        "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
      ];
    };

    dwindle = {
      pseudotile = 0; # enable pseudotiling on dwindle
      preserve_split = true;
    };

    misc = {
      enable_swallow = true;
      swallow_regex = "^(Alacritty)$";
      mouse_move_enables_dpms = true;
      disable_autoreload = true;
      focus_on_activate = true;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
    };

    group = {
      groupbar = {
        enabled = true;
        render_titles = false;
        font_size = 14;
        height = 14;
        font_family = "Inter";
        gradients = false;
        # text_color = "rgb(${colors.base05})";
        text_color = "$text";
        # "col.active" = "0xff${colors.base02}";
        # "col.inactive" = "0xff${colors.base00}";
        # "col.locked_active" = "0xff${colors.base02}";
        # "col.locked_inactive" = "0xff${colors.base00}";
      };
    };

    binds = {workspace_back_and_forth = true;};

    xwayland = {
      use_nearest_neighbor = false;
      force_zero_scaling = true;
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_create_new = false;
    };

    plugin = {
      dynamic-cursors = {
        enabled = false;
        mode = "tilt";
        shake = {
          effects = 1;
        };
        hyprcursor = {
          nearest = false;
        };
      };

      hy3 = {
        no_gaps_when_only = 0;

        tabs = {
          opacity = 0.8;
          "col.active" = "$sapphire";
          "col.text.active" = "$base";
          "col.inactive" = "$crust";
          "col.text.inactive" = "$text";
        };

        autotile = {
          enable = true;
        };
      };
    };
  };
}
