{ pkgs, osConfig, ... }:
let
  toRgba = let t = osConfig.lib.stylix.colors;
  in col: opacity:
  "rgba(${t."base${col}-rgb-r"},${t."base${col}-rgb-g"},${
    t."base${col}-rgb-b"
  },${opacity})";
in {
  services.avizo = {
    enable = true;
    package = pkgs.avizo.overrideAttrs (final: prev: {
      patchPhase = ''
        cp ${./images}/*.png data/images/
      '';
    });
    settings = with osConfig.lib.stylix.colors; {
      default = {
        time = 1.0;
        y-offset = 0.5;
        fade-in = 0.1;
        fade-out = 0.2;
        padding = 10;
        background = "${toRgba "00" "0.8"}";
        border-color = "${toRgba "00" "0.8"}";
        bar-bg-color = "${toRgba "01" "1"}";
        bar-fg-color = "${toRgba "05" "1"}";
        # image-base-dir = "${./images}";
      };
    };
  };
}
