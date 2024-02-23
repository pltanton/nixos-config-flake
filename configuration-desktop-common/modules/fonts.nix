{ pkgs, config, ... }: {
  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;
    fontDir.enable = true;

    packages = with pkgs; [ terminus_font inter ubuntu_font_family ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Inter" "Ubuntu" ];
        sansSerif = [ "Inter" "Ubuntu" ];
        monospace = [ "Inter" "Ubuntu" ];
      };
    };
  };
}
