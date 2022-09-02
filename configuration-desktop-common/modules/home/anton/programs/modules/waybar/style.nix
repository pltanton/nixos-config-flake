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

      backgroundColor_hex = "${config.lib.base16.theme.base00-hex}";
      base01_hex = base01-hex;
      base02_hex = base02-hex;
      base03_hex = base03-hex;
      base04_hex = base04-hex;
      base05_hex = base05-hex;
      base06_hex = base06-hex;
      base07_hex = base07-hex;
      base08_hex = base08-hex;
      base09_hex = base09-hex;
      base0A_hex = base0A-hex;
      base0B_hex = base0B-hex;
      base0C_hex = base0C-hex;
      base0D_hex = base0D-hex;
      base0E_hex = base0E-hex;
      base0F_hex = base0F-hex;

      inherit fontUIName;
    });

in { programs.waybar.style = styleFile; }
