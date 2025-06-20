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
    "b" = "1";

    "2" = "2";
    "t" = "2";

    "3" = "3";
    "e" = "3";

    "4" = "4";
    "i" = "4";

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
      accordion-padding = 20;
      on-focus-changed = [
        "move-mouse window-lazy-center"
        "exec-and-forget osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-index-jsx\"'"
      ];
      on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];
      exec-on-workspace-change = [
        "/bin/bash"
        "-c"
        "/usr/bin/osascript -e 'tell application id \"tracesOf.Uebersicht\" to refresh widget id \"simple-bar-index-jsx\"'"
      ];

      on-window-detected = [
        {
          "if".app-id = "com.tinyspeck.slackmacgap";
          run = ["move-node-to-workspace msg"];
        }
        {
          "if".app-id = "com.tdesktop.Telegram";
          run = ["move-node-to-workspace msg"];
        }
        {
          "if".app-id = "com.mitchellh.ghostty";
          run = ["layout tiling"];
        }
        {
          "if".app-id = "app.zen-browser.zen";
          run = ["move-node-to-workspace 1"];
        }
        {
          "if".app-id = "com.jetbrains.intellij";
          run = ["move-node-to-workspace 4"];
        }
        {
          "if".app-id = "dev.zed.zed";
          run = ["move-node-to-workspace 2"];
        }
      ];

      workspace-to-monitor-force-assignment = {
        "msg" = "secondary";
      };

      gaps = {
        inner.horizontal = 6;
        inner.vertical = 6;
        outer.left = 6;
        outer.bottom = 6;
        # outer.top = 40;
        outer.top = 6;
        outer.right = 6;
      };
      mode = {
        main.binding =
          {
            alt-shift-c = "close";
            alt-m = "macos-native-fullscreen";
            alt-f = "fullscreen";

            alt-r = "mode resize";
            alt-s = "mode service";

            # alt-shift-enter = "exec-and-forget open -a Ghostty";
            alt-shift-enter = ''
              exec-and-forget osascript -e 'tell application "Ghostty"
                  if it is running
                      tell application "System Events" to tell process "Ghostty"
                          click menu item "New Window" of menu "File" of menu bar 1
                      end tell
                  else
                      activate
                  end if
              end tell'
            '';

            alt-shift-quote = "move-workspace-to-monitor --wrap-around prev";
            alt-quote = "focus-monitor --wrap-around prev";
            alt-shift-comma = "move-workspace-to-monitor --wrap-around next";
            alt-comma = "focus-monitor --wrap-around next";

            alt-v = "layout tiles horizontal vertical";
            alt-g = "layout accordion horizontal vertical";
          }
          // (lib.mapAttrs' (key: direction: lib.nameValuePair "alt-${key}" "focus ${direction} --boundaries all-monitors-outer-frame") directions)
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
