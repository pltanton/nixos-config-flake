orig: pkgs:

with orig; {
  home = home // {
    packages = home.packages ++ (with pkgs; [
      #texlive.combined.scheme-full texlab zathura
      jetbrains.idea-ultimate
      gnuplot
      antlr

      phockup
      exiftool
      #androidsdk

      #nix-deploy

      discord
      #wine
      ghc
      insomnia
      gimp
      darktable
      libreoffice-fresh
      sipcalc

      #transmission-gtk
      #transmission-remote-gtk

      visualvm
      plantuml

      #kdenlive
      breeze-icons

      xboxdrv
    ]);
  };
}
