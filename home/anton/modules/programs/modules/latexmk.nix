{pkgs, ...}:
{
  home.file.".config/awesome/themes/pltanton/colors.lua".text = ''
  $pdflatex=q/lualatex -synctex=1 -shell-escape %O %S/
  '';
}
