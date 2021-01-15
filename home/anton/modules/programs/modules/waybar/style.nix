{ pkgs, config, ... }:
let
  toRgba = let t = config.lib.base16.theme;
  in col: opacity:
  "rgba(${t."base${col}-rgb-r"},${t."base${col}-rgb-g"},${
    t."base${col}-rgb-b"
  },${opacity})";

  backgroundColor-hex = "21242b";

  css = with config.lib.base16.theme; ''
    * {
        border: none;
        border-radius: 0;
        font-family: ${fontUIName},'Font Awesome 5', 'SFNS Display',  Helvetica, Arial, sans-serif;
        font-size: 18px;
        min-height: 0;
    }

    window#waybar {
        background: #${backgroundColor-hex};
        background-clip: padding-box;

        border-bottom: 3px solid rgba(1, 1, 1, 0);
        color: #${base05-hex};
    }

    window#waybar.hidden {
        opacity: 0.0;
    }

    /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
    #workspaces button {
        padding: 0 1px;
        background: transparent;
        color: #${base05-hex};
        border-bottom: 3px solid transparent;
    }

    #workspaces button.visible {
        background: #${base00-hex};
        border-bottom: 3px solid #${base00-hex};
    }

    #workspaces button.focused {
        background: #${base00-hex};
        border-bottom: 3px solid #${base0D-hex};
    }

    #workspaces button.urgent {
        background-color: #${base08-hex};
    }

    #mode {
        background: #64727D;
        border-bottom: 3px solid #${base05-hex};
    }

    #clock, #battery, #cpu, #memory, #temperature, #backlight, #network,
    #pulseaudio, #custom-media, #tray, #mode, #idle_inhibitor, #custom-spotify,
    #custom-layout  {
        padding: 5px 10px;
        margin: 0 3px;
        background-clip: border-box;
        border-bottom: 3px solid #${base01-hex};
    }

    #clock {
    }

    #custom-layout {
    }

    #battery {
        border-bottom: 3px solid #${base0D-hex};
    }

    #battery.charging {
        border-bottom: 3px solid #${base0B-hex};
    }

    @keyframes blink {
        to {
            background-color: #${base05-hex};
            color: #000000;
        }
    }

    #battery.critical:not(.charging) {
        background: #${base08-hex};
        color: #ffffff;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }

    #cpu {
        background: #2ecc71;
        color: #${base04-hex};
    }

    #memory {
        background: #9b59b6;
    }

    #backlight {
        background: #90b1b1;
    }

    #network {
        background-color: #${base0B-hex};
        color: #${base01-hex};
    }

    #network.disabled {
        background: #f53c3c;
        color: #${base01-hex};
    }

    #network.disconnected {
        background: #f53c3c;
    }

    #pulseaudio {
        border-bottom: 3px solid #${base0A-hex};
    }

    #pulseaudio.muted {
        background-color: #${base01-hex};
        border-bottom: 3px solid #${base01-hex};
    }

    #custom-media {
        background: #66cc99;
        color: #2a5c45;
    }

    #tray {
    }

    #idle_inhibitor {
    }

    #idle_inhibitor.activated {
        background-color: #${base06-hex};
        color: #${base04-hex};
        border-bottom: 3px solid #${base06-hex};
    }

    #custom-spotify {
        color: #${base01-hex};
        background-color: #1DB954;
    }
  '';
in { programs.waybar.style = css; }
