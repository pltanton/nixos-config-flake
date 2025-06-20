{pkgs, ...}: {
  services.yabai = {
    enable = false;
    config = {
      # Set all padding and gaps to 20pt (default: 0)
      top_padding = "6";
      bottom_padding = "6";
      left_padding = "6";
      right_padding = "6";
      window_gap = "12";

      # Useful optional stuff
      "focus_follows_mouse" = "autofocus";
      "window_shadow" = "float";

      # Drag/resizes Windows with mouse without having to grab the edges first by holding ctrl
      "mouse_modifier" = "ctrl";
      "mouse_action1" = "move";
      "mouse_action2" = "resize";
    };
    extraConfig = ''
      sudo yabai --load-sa
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
      yabai -m config layout bsp

      # Space labels
      yabai -m space 1 --label main
      yabai -m space 2 --label web
      yabai -m space 3 --label chat
      yabai -m space 4 --label music
      yabai -m space 5 --label editors

      yabai -m rule --add app="^DaVinci Resolve$" space=1
      #yabai -m rule --add app="^Firefox$" space=2
      #yabai -m rule --add app="^Safari$" space=2
      yabai -m rule --add app="^Discord$" space=3
      yabai -m rule --add app="^Spotify$" space=4
      yabai -m rule --add app="^Visual Studio Code$" space=5


      # Window rules
      yabai -m rule --add app="^(Calculator|System Preferences|System Settings|Archive Utility)$" manage=off
      yabai -m rule --add title="^Preferences" manage=off
      yabai -m rule --add title="^Settings" manage=off
      yabai -m rule --add app="^Steam$" manage=off
      yabai -m rule --add app="^Notes$" manage=off
      yabai -m rule --add app="^QuickTime Player$" manage=off
      yabai -m rule --add app="^Numi$" manage=off
      yabai -m rule --add app="^Kawa$" manage=off
      yabai -m rule --add app="^Weather$" manage=off
      # Anki card preview & Anki browser
      yabai -m rule --add title="^Preview" manage=off
      yabai -m rule --add title="^Anki" manage=off
      yabai -m rule --add title="^Browse" manage=off


      # Set all windows layer to normal so non managed windows wouldnt be always on top https://github.com/koekeishiya/yabai/issues/1912
      yabai -m rule --add app=".*" sub-layer=normal
    '';
    enableScriptingAddition = true;
  };
}
