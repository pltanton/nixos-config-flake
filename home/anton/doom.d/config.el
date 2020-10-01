;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Anton Plotnikov"
      user-mail-address "plotnikovanton@gmail.com")

(setq doom-theme 'doom-one)

(setq org-directory "~/nextcloud/orgmode/")

(setq display-line-numbers-type "relative")

(setq doom-font (font-spec :family "Iosevka" :size 28))


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(doom! :checkers
       syntax
       spell
       :editor
       (evil +everywhere)
       fold
       (format +onsave)
       :emacs
       undo
       :tools
       lsp
       magit
       editorconfig
       :ui
       modeline
       tabs
       treemacs
       (ligatures +iosevka)
       :completion
       (company +childframe)
       :lang
       kotlin
       latex
       markdown
       python
       go
       javascript
       json
       (yaml +lsp)
       haskell
       nix
       org
       (sh +fish))
