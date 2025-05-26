{lib, ...}: let
  directions = rec {
    left = "left";
    right = "right";
    up = "up";
    down = "down";
    h = left;
    j = down;
    k = up;
    l = right;
  };
  workspaces = {
    "1" = "1";
    "2" = "2";
    "3" = "3";
    "4" = "4";
    "5" = "5";
    "6" = "6";
    "7" = "7";
    "8" = "8";
    "9" = "9";
    "0" = "10";
    "tab" = "msg";
  };
in {
  programs.aerospace = {
    enable = true;
    userSettings = {
      start-at-login = true;
      key-mapping.preset = "dvorak";
      automatically-unhide-macos-hidden-apps = true;
      on-focus-changed = ["move-mouse window-lazy-center"];
      on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];
      mode = {
        main.binding =
          {
            alt-shift-c = "close";
            alt-m = "macos-native-fullscreen";
            alt-f = "fullscreen";

            alt-1 = "workspace 1";
            alt-2 = "workspace 2";

            alt-r = "mode resize";
            alt-s = "mode service";

            alt-shift-enter = "exec-and-forget open -a Ghostty -n";

            alt-shift-comma = "move-workspace-to-monitor --wrap-around next";
            alt-comma = "focus-monitor --wrap-around next";

            alt-v = "layout tiles horizontal vertical";
            alt-g = "layout accordion horizontal vertical";
          }
          // (lib.mapAttrs' (key: direction: lib.nameValuePair "alt-${key}" "focus ${direction}") directions)
          // (lib.mapAttrs' (key: direction: lib.nameValuePair "alt-shift-${key}" "move ${direction}") directions)
          // (lib.mapAttrs' (key: wspc: lib.nameValuePair "alt-${key}" "workspace ${wspc}") workspaces)
          // (lib.mapAttrs' (key: wspc: lib.nameValuePair "alt-shift-${key}" ["move-node-to-workspace ${wspc}" "workspace ${wspc}"]) workspaces);

        service.binding = {
          esc = ["reload-config" "mode main"];
          r = ["flatten-workspace-tree" "mode main"]; # reset layout
          f = ["layout floating tiling" "mode main"]; # Toggle between floating and tiling layout

          # sticky is not yet supported https://github.com/nikitabobko/AeroSpace/issues/2
          #s = ["layout sticky tiling", "mode main"]

          h = ["join-with left" "mode main"];
          j = ["join-with down" "mode main"];
          k = ["join-with up" "mode main"];
          l = ["join-with right" "mode main"];
        };

        resize.binding = {
          h = "resize width -50";
          j = "resize height +50";
          k = "resize height -50";
          l = "resize width +50";
          enter = "mode main";
          esc = "mode main";
        };
      };
    };
  };
}
