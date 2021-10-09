{pkgs, ...}:
{
  home.file.".latexmkrc".text = ''
  $pdflatex=q/lualatex -synctex=1 -shell-escape %O %S/
  '';
}
