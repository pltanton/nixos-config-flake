{ pkgs, config, ... }:

{
  # imports = [ inputs.nix-doom-emacs.hmModule ];
  # programs.doom-emacs = {
  #   enable = false;
  #   package = pkgs.waylandPkgs.emacs-pgtk;
  #   doomPrivateDir = ./doom.d;
  # };

  home.packages = with pkgs; [
    waylandPkgs.emacs-pgtk
    # nur.repos.metadark.emacs-pgtk-nativecomp

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
}
