{ pkgs, config, ... }: {
  fonts = {
    enableDefaultFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      terminus_font
      inter
      ubuntu_font_family
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Inter" "Ubuntu" ];
        sansSerif = [ "Inter" "Ubuntu" ];
        monospace = [ "Inter" "Ubuntu" ];
      };
    };
  };
}
