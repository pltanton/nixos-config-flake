{ pkgs, config, inputs, ... }:

let
  doom-emacs = pkgs.callPackage inputs.nixDoomEmacs { doomPrivateDir = ./doom.d; };
in {
  #home.packages = [ doom-emacs ];

  home.packages = with pkgs; [
    emacs

    ripgrep
    fd

    aspell
    editorconfig-core-c

    gocode
    gomodifytags
    gotests
    gore
    goimports

    hlint
    cabal-install

    ktlint

    shellcheck

    pipenv
  ];

  #home.file.".emacs.d/init.el".text = ''
  #  (load "default.el")
  #'';
}
