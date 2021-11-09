{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      golang.Go
      vscodevim.vim
      bbenoist.Nix
    ];
  };
}
