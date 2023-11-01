{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    # package = pkgs.master.vscodium;
    extensions = with pkgs.vscode-extensions; [
      golang.go
      vscodevim.vim
      bbenoist.nix
    ];
  };
}
