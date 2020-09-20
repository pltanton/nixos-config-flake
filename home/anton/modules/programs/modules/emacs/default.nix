{ pkgs, config, ... }:

{
  home.file = {
    ".emacs.d/config.org" = {
      text = import ./emacs.org pkgs config.lib.base16;
      onChange = "rm ~/.emacs.d/config.el";
    };
    ".emacs.d/init.el".text = ''(org-babel-load-file "~/.emacs.d/config.org")'';
  };

  services.emacs.enable = true;

  programs.emacs = {
    enable = true;
    extraPackages = epkgs:
      with epkgs; [
        esup
        use-package

        evil
        evil-org
        evil-leader

        telephone-line
        centaur-tabs
        all-the-icons

        which-key

        ivy
        counsel
        counsel-projectile
        flx
        ranger
        base16-theme

        git-gutter
        magit
        evil-magit
        treemacs-magit

        projectile
        treemacs
        treemacs-projectile
        treemacs-evil
        treemacs-icons-dired

        org-bullets
        org-plus-contrib
        gnuplot

        diminish

        nix-mode
        yaml-mode
        lua-mode

        rainbowDelimiters
        beacon

        go-mode

        haskell-mode

        typescript-mode

        prettier-js
        lsp-mode
        flycheck
        lsp-ui
        lsp-treemacs
        elisp-format
        company

        pdf-tools
        auctex
        auctex-latexmk

        vue-mode

        rainbow-mode
      ];
  };
}
