{ pkgs, config, ... }:
let
  toRgba = let t = config.lib.base16.theme;
           in col: opacity: "rgba(${t."base${col}-rgb-r"},${t."base${col}-rgb-g"},${t."base${col}-rgb-b"},${opacity})";

  css = with config.lib.base16.theme; ''
    * {
        border: none;
        border-radius: 0;
        font-family: ${fontUIName},'Font Awesome 5', 'SFNS Display',  Helvetica, Arial, sans-serif;
        font-size: ${fontUISize}px;
        min-height: 0;
    }

    window#waybar {
        background: #${base01-hex};
        background-clip: padding-box;

        border-bottom: 3px solid rgba(1, 1, 1, 0);
        color: #${base05-hex};
    }

    window#waybar.hidden {
        opacity: 0.0;
    }

    /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
    #workspaces button {
        padding: 0 3px;
        background: transparent;
        color: #${base05-hex};
        border-bottom: 3px solid transparent;
    }

    #workspaces button.visible {
        background: #${base00-hex};
        border-bottom: 3px solid rgba(90, 90, 90, 0.5);
    }

    #workspaces button.focused {
        background: #${base00-hex};
        border-bottom: 3px solid #${base05-hex};
    }

    #workspaces button.urgent {
        background-color: #${base08-hex};
    }

    #mode {
        background: #64727D;
        border-bottom: 3px solid #${base05-hex};
    }

    #clock, #battery, #cpu, #memory, #temperature, #backlight, #network,
    #pulseaudio, #custom-media, #tray, #mode, #idle_inhibitor, #custom-spotify  {
        padding: 0 10px;
        margin: 0 3px;
        background-clip: border-box;
        border-bottom: 3px solid rgba(90, 90, 90, 0.5);
    }

    #clock {
        background-color: #${base00-hex};
    }

    #battery {
        background-color: #${base0D-hex};
        color: #${base00-hex};
    }

    #battery.charging {
        color: #${base00-hex};
        background-color: #26A65B;
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
        background: #2980b9;
    }

    #network.disconnected {
        background: #f53c3c;
    }

    #pulseaudio {
        background: #${base0A-hex};
        color: #${base04-hex};
    }

    #pulseaudio.muted {
        background: #${base0B-hex};
        color: #${base04-hex};
    }

    #custom-media {
        background: #66cc99;
        color: #2a5c45;
    }

    #tray {
        background-color: #${base00-hex};
    }

    #idle_inhibitor {
        background-color: #${base00-hex};
    }

    #idle_inhibitor.activated {
        background-color: #${base06-hex};
        color: #${base04-hex};
    }

    #custom-spotify {
        color: #${base00-hex};
        background-color: #1DB954;
    }
  '';
in { programs.waybar.style = css; }
