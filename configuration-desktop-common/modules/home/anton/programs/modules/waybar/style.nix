{ pkgs, config, osConfig, ... }:
let
  toRgba = let t = config.lib.base16.theme;
  in col: opacity:
  "rgba(${t."base${col}-rgb-r"},${t."base${col}-rgb-g"},${
    t."base${col}-rgb-b"
  },${opacity})";

  theme = config.lib.base16.theme;
  backgroundColor-hex = "${theme.base00-hex}";

  styleFile = with osConfig.lib.stylix.colors;
    pkgs.substituteAll ({
      src = ./style.css;

      backgroundColor = base00;
      base0 = base00;
      base1 = base01;
      base2 = base02;
      base3 = base03;
      base4 = base04;
      base5 = base05;
      base6 = base06;
      base7 = base07;
      base8 = base08;
      base9 = base09;
      baseA = base0A;
      baseB = base0B;
      baseC = base0C;
      baseD = base0D;
      baseE = base0E;
      baseF = base0F;

      # TODO Replace it with stylix
      gradientStylix0 = osConfig.lib.stylix.extracolors.gradient00;
      gradient0 = "8fbcbb";
      gradient1 = "88c0d0";
      gradient2 = "81a1c1";
      gradient3 = "5e81ac";

      fontUIName = "Inter";
    });

in { programs.waybar.style = styleFile; }
