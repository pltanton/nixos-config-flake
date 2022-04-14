{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      golang.go
      vscodevim.vim
      bbenoist.nix
      github.copilot
    ];
  };
}
