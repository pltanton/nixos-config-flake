{ pkgs, ... }:

{
  programs.vscode = {
    enable = false;
    extensions = with pkgs.vscode-extensions; [
      golang.go
      vscodevim.vim
      bbenoist.nix
      github.copilot
    ];
  };
}
