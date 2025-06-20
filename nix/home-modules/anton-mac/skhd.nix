{pkgs, ...}: {
  services = {
    skhd = {
      enable = false;
      config = ''
        # Navigation
        ctrl + cmd - h : yabai -m window --focus west
        ctrl + cmd - l : yabai -m window --focus east
        ctrl + cmd - j : yabai -m window --focus south
        ctrl + cmd - k : yabai -m window --focus north

        # Focus different monitor
        # ctrl - t : yabai -m display --focus next || yabai -m display --focus first

        # Moving windows
        ctrl + shift - h : yabai -m window --warp west
        ctrl + shift - l : yabai -m window --warp east
        ctrl + shift - j : yabai -m window --warp south
        ctrl + shift - k : yabai -m window --warp north

        # Rotate layout
        ctrl - l : yabai -m space --rotate 90
        # Balance the layout
        ctrl - k : yabai -m space --balance

        # Move focus container to display (use "space" instead of display to move to just per space instead)
        ctrl + shift - x : yabai -m window --display 1 --focus # main monitor
        ctrl + shift - z : yabai -m window --display 2 --focus # vertical
        ctrl + shift - c : yabai -m window --display 3 --focus # laptop

        # Move focus container to space
        ctrl + alt - 1 : yabai -m window --space 1 --focus # main
        ctrl + alt - 2 : yabai -m window --space 2 --focus # web
        ctrl + alt - 3 : yabai -m window --space 3 --focus # chat
        ctrl + alt - 4 : yabai -m window --space 4 --focus # music
        ctrl + alt - 5 : yabai -m window --space 5 --focus # editors
        ctrl + alt - 6 : yabai -m window --space 6 --focus # immersion
        ctrl + alt - 7 : yabai -m window --space 7 --focus # anki
        ctrl + alt - 8 : yabai -m window --space 8 --focus # terminal
        ctrl + alt - 9 : yabai -m window --space 9 --focus # space 9

        # Resize windows
        ctrl - a : yabai -m window --resize left:-100:0 ; yabai -m window --resize right:-100:0
        ctrl - s : yabai -m window --resize bottom:0:100 ; yabai -m window --resize top:0:100
        ctrl - w : yabai -m window --resize top:0:-100 ; yabai -m window --resize bottom:0:-100
        ctrl - d : yabai -m window --resize right:100:0 ; yabai -m window --resize left:100:0


        # Float / Unfloat window
        ctrl - space : yabai -m window --toggle float

        # Change layout type for space
        ctrl - j : yabai -m space --layout stack
        ctrl - h : yabai -m space --layout $(yabai -m query --spaces --space | jq -r 'if .type == "bsp" then "float" else "bsp" end')

        # Make fullscreen
        ctrl - f         : yabai -m window --toggle zoom-fullscreen
        # Toggle padding on/off
        ctrl - g         : yabai -m space --toggle padding --toggle gap
        # Disable padding overall
        ctrl - y         : yabai -m config top_padding 0 \ yabai -m config bottom_padding 0 \ yabai -m config left_padding 0 \ yabai -m config right_padding 0 \ yabai -m config window_gap 0
        ctrl - u         : yabai -m config window_gap 12
        # Focus
        ctrl - o         : yabai -m config focus_follows_mouse autofocus
        ctrl - p         : yabai -m config focus_follows_mouse off

        # F KEYS
        #f1 : yabai -m space --focus 1
        #f2 : yabai -m space --focus 2
        #f3 : yabai -m space --focus 3
        #f4 : yabai -m space --focus 4
        #f5 : yabai -m space --focus 5

        # Change desktop (can also be set up from native macOS keyboard shortcuts under Keyboard Shortcuts > Mission Control > Switch to Desktop X)
        # ctrl - 1 : yabai -m space --focus 1
        # ctrl - 2 : yabai -m space --focus 2
        # ctrl - 3 : yabai -m space --focus 3
        # ctrl - 4 : yabai -m space --focus 4
        # ctrl - 5 : yabai -m space --focus 5
        # ctrl - 6 : yabai -m space --focus 6
        # ctrl - 7 : yabai -m space --focus 7
        # ctrl - 8 : yabai -m space --focus 8
        # ctrl - 9 : yabai -m space --focus 9
        # ctrl - 0 : yabai -m space --focus 10

        # Unused
        # ctrl - 1 : yabai -m display --focus 3
        # ctrl - 2 : yabai -m display --focus 1
        # ctrl - 3 : yabai -m display --focus 2

        # Create space on the active display
        ctrl - n : yabai -m space --create

        # Delete focused space and focus first space on display
        ctrl - m : yabai -m space --destroy

        # Control Audio Output Device
        ctrl - e : SwitchAudioSource -s "FiiO USB DAC-E10"
        ctrl - r : SwitchAudioSource -s "MacBook Pro Speakers"
        # ctrl - r : SwitchAudioSource -s "MacBook Proのスピーカー"

        # Destroy empty spaces
        ctrl + alt + shift - d : yabai -m query --spaces --display | \
             jq -re 'map(select(."is-native-fullscreen" == false)) | length > 1' \
             && yabai -m query --spaces | \
                  jq -re 'map(select(."windows" == [] and ."has-focus" == false).index) | reverse | .[] ' | \
                  xargs -I % sh -c 'yabai -m space % --destroy'


        # Monster query to properly set up spaces when using DR (ODO create missing spaces, delete unnecessary ones, create missing spaces again)
        # First line is to get DR Window ID, then get space that has that window, then move that space to be space 1
        ctrl - q : yabai -m query --windows | jq '.[] | select(.app | test("DaVinci Resolve")).id' | xargs -L1 sh -c 'yabai -m query --spaces | jq ".[] | select(.windows[] == $0).index"' | xargs -I{} yabai -m space {} --move 1 ; yabai -m query --windows | jq '.[] | select(.app | test("Firefox")).id' | xargs -L1 sh -c 'yabai -m query --spaces | jq ".[] | select(.windows[] == $0).index"' | xargs -I{} yabai -m space {} --move 2 ; yabai -m query --windows | jq '.[] | select(.app | test("Discord")).id' | xargs -L1 sh -c 'yabai -m window $0 --space 3' ; yabai -m query --windows | jq '.[] | select(.app | test("Spotify")).id' | xargs -L1 sh -c 'yabai -m window $0 --space 4' ; yabai -m query --windows | jq '.[] | select(.app | test("Code")).id' | xargs -L1 sh -c 'yabai -m window $0 --space 5' ; yabai -m query --windows | jq '.[] | select(.app | test("Anki")).id' | xargs -L1 sh -c 'yabai -m window $0 --space 7' ; yabai -m query --windows | jq '.[] | select(.app | test("Google Chrome")).id' | xargs -L1 sh -c 'yabai -m window $0 --space 6' ; yabai -m query --windows | jq '.[] | select(.app | test("iTerm2")).id' | xargs -L1 sh -c 'yabai -m window $0 --space 1' ; yabai -m query --windows | jq '.[] | select(.app | test("Firefox")).id' | xargs -L1 sh -c 'yabai -m window $0 --space 2'

        # Similar query but for when sentence mining with Chrome, which goes to space 1
        # ctrl + shift - q : yabai -m query --windows | jq '.[] | select(.title | test("Google Chrome")).id' | xargs -L1 sh -c 'yabai -m query --spaces | jq ".[] | select(.windows[] == $0).index"' | xargs -I{} yabai -m space {} --move 1 ; yabai -m query --windows | jq '.[] | select(.app | test("Firefox")).id' | xargs -L1 sh -c 'yabai -m query --spaces | jq ".[] | select(.windows[] == $0).index"' | xargs -I{} yabai -m space {} --move 2 ; yabai -m query --windows | jq '.[] | select(.app | test("Discord")).id' | xargs -L1 sh -c 'yabai -m window $0 --space 3' ; yabai -m query --windows | jq '.[] | select(.app | test("Spotify")).id' | xargs -L1 sh -c 'yabai -m window $0 --space 4' ; yabai -m query --windows | jq '.[] | select(.app | test("Code")).id' | xargs -L1 sh -c 'yabai -m window $0 --space 5' ; yabai -m query --windows | jq '.[] | select(.app | test("iTerm2")).id' | xargs -L1 sh -c 'yabai -m window $0 --space 8'


        # Open new firefox tabs with ctrl + numpad 1/2
        ctrl - f1 : open -n -a "Firefox" --args "--new-tab" "https://example.com"

        # If Alacritty isn't running, open it normally, if its running, send it a signal to open a new window (otherwise open just focuses it, and -n flag creates a different instance)
        ctrl - return : ps aux | grep -v grep | grep -q "Alacritty" && echo "Alacritty is running" && alacritty msg create-window || echo "Alacritty is not running" && open -a Alacritty
        ctrl + shift - return : open -a Firefox
        ctrl + cmd - return : open ~/Downloads

        # Open finder in a certain path
        ctrl + cmd - return : open /Users/name/example/path

        # Quickly restart yabai
        ctrl + alt + cmd - r : yabai --restart-service

        # Download song from clipboard to Downloads
        ctrl + alt + cmd - l : yt-dlp "$(pbpaste)" -o "~/Downloads/%(title)s.%(ext)s" --extract-audio

        # Shortcut to start/stop recording system audio, save it to /Downloads, copy path to clipboard
        ctrl - m : fname=~/Downloads/a_$(date +'%y%m%d-%H%M%S').wav && if pgrep -x "sox"; then pkill sox && osascript -e "display notification \"$fname\" with title \"Stopped audio recording\""; else  osascript -e "display notification \"$fname\" with title \"Started audio recording\"" && sox -t coreaudio "BlackHole 2ch" "$fname" && echo "file://$fname" | pbcopy && osascript -e "tell application \"Finder\" to set the clipboard to (POSIX file \"$fname\")"; fi
      '';
    };
  };
}
