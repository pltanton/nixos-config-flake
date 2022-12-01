{ pkgs, config, ... }:
let
  toRgba = let t = config.lib.base16.theme;
  in col: opacity:
  "rgba(${t."base${col}-rgb-r"},${t."base${col}-rgb-g"},${
    t."base${col}-rgb-b"
  },${opacity})";

  theme = config.lib.base16.theme;
  backgroundColor-hex = "${theme.base00-hex}";

  styleFile = with theme;
    pkgs.substituteAll ({
      src = ./style.css;

      backgroundColor = base00-hex;
      base0 = base00-hex;
      base1 = base01-hex;
      base2 = base02-hex;
      base3 = base03-hex;
      base4 = base04-hex;
      base5 = base05-hex;
      base6 = base06-hex;
      base7 = base07-hex;
      base8 = base08-hex;
      base9 = base09-hex;
      baseA = base0A-hex;
      baseB = base0B-hex;
      baseC = base0C-hex;
      baseD = base0D-hex;
      baseE = base0E-hex;
      baseF = base0F-hex;

      inherit gradient0 gradient1 gradient2 gradient3;

      inherit fontUIName;
    });

in { programs.waybar.style = styleFile; }
