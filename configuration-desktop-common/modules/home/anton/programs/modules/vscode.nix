{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      golang.Go
      vscode.vim
      bbenoist.Nix
    ];
  };
}
