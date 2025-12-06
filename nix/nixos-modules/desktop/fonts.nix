{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;
    enableGhostscriptFonts = true;

    packages = with pkgs; [terminus_font inter ubuntu-classic];

    fontconfig = {
      defaultFonts = {
        serif = ["Inter" "Ubuntu"];
        sansSerif = ["Inter" "Ubuntu"];
        monospace = ["Inter" "Ubuntu"];
      };
    };
  };
}
