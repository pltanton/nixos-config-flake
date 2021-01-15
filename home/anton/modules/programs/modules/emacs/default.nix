{ pkgs, config, inputs, nur, ... }:

{
  programs.doom-emacs = {
    enable = true;
    # emacsPackage = pkgs.waylandPkgs.emacs-pgtk;
    # emacsPackage = pkgs.nur.repos.metadark.emacs-pgtk-nativecomp;
    # emacsPackage = pkgs.emacsPgtk;
    emacsPackage = pkgs.emacs;
    # emacsPackage = pkgs.emacsUnstable;
    doomPrivateDir = ./doom.d;
  };

  home.packages = with pkgs; [
    ripgrep
    hunspell
    hunspellDicts.en-us
    hunspellDicts.en-gb-large
    hunspellDicts.ru-ru
  ];

  #home.packages = with pkgs; [
  #  emacsPgtkGcc
  #  # emacsGcc
  #  # emacsPgtk
  #  # emacs
  #  emacs-all-the-icons-fonts
  #  # nur.repos.metadark.emacs-pgtk-nativecomp
  #  # emacs

  #  ripgrep
  #  fd

  #  hunspell
  #  hunspellDicts.en-us
  #  hunspellDicts.ru-ru
  #  hunspellDicts.en-gb-large

  #  editorconfig-core-c

  #  gocode
  #  gomodifytags
  #  gotests
  #  gore
  #  goimports

  #  hlint
  #  cabal-install

  #  shellcheck

  #  pipenv
  #];
}
