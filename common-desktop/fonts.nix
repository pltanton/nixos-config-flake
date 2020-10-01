{ pkgs, ... }: {
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [ terminus_font ];
  };
}
