{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.master.vscodium;
    extensions = with pkgs.vscode-extensions; [
      golang.go
      vscodevim.vim
      bbenoist.nix
      alefragnani.project-manager
      vspacecode.vspacecode
      vspacecode.whichkey
      catppuccin.catppuccin-vsc-icons
      catppuccin.catppuccin-vsc
      foam.foam-vscode
      esbenp.prettier-vscode
      yzhang.markdown-all-in-one
    ];
  };
}
