{ pkgs, config, ... }:
let
  toRgba = let t = config.lib.base16.theme;
  in col: opacity:
  "rgba(${t."base${col}-rgb-r"},${t."base${col}-rgb-g"},${
    t."base${col}-rgb-b"
  },${opacity})";

  backgroundColor-hex = "${config.lib.base16.theme.base00-hex}";

  css = with config.lib.base16.theme; ''
    * {
        border: none;
        border-radius: 0;
        font-family: ${fontUIName},'Font Awesome 5', 'SFNS Display',  Helvetica, Arial, sans-serif;
        font-size: 18.5px;
        min-height: 0;
    }

    window#waybar {
        background: #${backgroundColor-hex};
        /* background: rgba(0,0,0,0); */
        background-clip: padding-box;
        color: #${base05-hex};
    }

    window#waybar.hidden {
        opacity: 0.0;
    }

    /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
    #workspaces button {
        padding: 0 8px;
        background: transparent;
        color: #${base05-hex};
    }

    #workspaces button.visible {
        background: #${base00-hex};
        border-bottom: 3px solid #${base00-hex};
    }

    #workspaces button.focused {
        background: #${base00-hex};
        border-bottom: 3px solid #${base0D-hex};
    }

    #workspaces button.active {
        background: #${base00-hex};
        border-bottom: 3px solid #${base0D-hex};
    }

    #workspaces button.urgent {
        background-color: #${base08-hex};
    }

    #mode {
        background: #64727D;
        /* border-bottom: 3px solid #${base05-hex}; */
    }

    #clock, #battery, #cpu, #memory, #temperature, #backlight, #network,
    #pulseaudio, #custom-media, #tray, #mode, #idle_inhibitor, #custom-spotify,
    #custom-layout, #language  {
        background-color: #${base01-hex};
        padding: 0 12px;
        margin: 9px 4px 9px 4px;
        border-radius: 90px;
        background-clip: padding-box;
    }

    #clock {
    }

    #custom-layout {
    }

    #battery {
        /* border-bottom: 3px solid #${base0D-hex}; */
        color: #${base0D-hex};
    }

    #battery.charging {
        /* border-bottom: 3px solid #${base0B-hex}; */
        color: #${base0B-hex};
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
        /* border-bottom: 3px solid #${base0A-hex}; */
        color: #${base0A-hex};
        min-width: 1.5em;
    }

    #pulseaudio.muted {
        background-color: #${base02-hex};
        /* border-bottom: 3px solid #${base01-hex}; */
        color: #${base00-hex};
    }

    #custom-media {
        background: #66cc99;
        color: #2a5c45;
    }

    #tray {
    }

    #idle_inhibitor {
        min-width: 1.5em;
    }

    #idle_inhibitor.deactivated {
        color: #${base00-hex};
    }

    #idle_inhibitor.activated {
        background-color: #${base02-hex};
        /* color: #${base04-hex};
        color: #${base05-hex};
        border-bottom: 3px solid #${base06-hex}; */
    }

    #custom-spotify {
        color: #${base01-hex};
        background-color: #1DB954;
    }

    #language {
        min-width: 1.5em;
    }
  '';
in { programs.waybar.style = css; }
