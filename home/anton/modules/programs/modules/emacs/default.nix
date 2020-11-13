{ pkgs, config, inputs, ... }:

{
  imports = [ inputs.nix-doom-emacs.hmModule ];
  programs.doom-emacs = {
    enable = true;
    emacsPackage = pkgs.waylandPkgs.emacs-pgtk;
    # emacsPackage = pkgs.emacsGcc;
    doomPrivateDir = ./doom.d;
  };

  home.packages = with pkgs; [ ripgrep ];

  # home.packages = with pkgs; [
  #   waylandPkgs.emacs-pgtk
  #   # nur.repos.metadark.emacs-pgtk-nativecomp
  #   # emacs

  #   ripgrep
  #   fd

  #   aspell
  #   editorconfig-core-c

  #   gocode
  #   gomodifytags
  #   gotests
  #   gore
  #   goimports

  #   hlint
  #   cabal-install

  #   ktlint

  #   shellcheck

  #   pipenv
  # ];
}
