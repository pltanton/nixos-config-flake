;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
;; (setq gc-cons-threshold 1000000000)
;; (setq read-process-output-max (* 3 (* 1024 1024))) ;; 1mb
;; (setq redisplay-dont-pause t)


(setq user-full-name "Anton Plotnikov"
      user-mail-address "plotnikovanton@gmail.com")

(setq doom-theme 'doom-nord)
;; (setq doom-theme 'doom-one)
;; (setq doom-theme 'doom-gruvbox)
;; (setq doom-gruvbox-dark-variant "hard")

(setq display-line-numbers-type "relative")

(setq doom-font (font-spec :family "Iosevka" :size 29))

(make-directory "~/org" t)
(setq org-directory "~/org")

;; Org roam configuration

(make-directory "~/org-roam" t)
(setq org-roam-directory "~/org-roam")
(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))


(setq projectile-project-search-path '("~/Workdir/" "~/Workdir/ozon" "~/Workdir/blackbird-platform" ))


(setq calendar-week-start-day 1)
(setq persist--directory-location "~/.emacs.d/persist")

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

(after! org
  (map! :map org-mode-map
        :n "M-j" #'org-metadown
        :n "M-k" #'org-metaup)
  )

(map! :ne "C-/" #'comment-or-uncomment-region)

(set-popup-rule! "^\\*Org Agenda" :side 'bottom :size 0.90 :select t :ttl nil)
(set-popup-rule! "^CAPTURE.*\\.org$" :side 'bottom :size 0.90 :select t :ttl nil)
(set-popup-rule! "^\\*org-brain" :side 'right :size 1.00 :select t :ttl nil)

;; Local project snippets

(setq +snippets-dir "~/.emacs.d/snippets")
(defun add-project-snippets ()
  (let ((dir (expand-file-name "snippets" projectile-project-root)))
    (when (file-directory-p dir)
      (add-to-list 'yas-snippets-dir dir))))

(add-hook 'projectile-after-switch-project-hook #'add-project-snippets)

(require 'quail)
(setq yas-triggers-in-field t)


;; Russian language support
;; (load-file "~/.doom.d/cyrillic-dvorak.el")
;; (setq default-input-method "cyrillic-dvorak")

(after! ispell
  (setenv "LANG" "en_US")
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "ru_RU,en_GB,en_US")
  (setq ispell-dictionary "ru_RU,en_GB,en_US")
  )

;; Add golang extra configuration
(after! go-mode
  (setq gofmt-command "goimports"))


;; LSP extra configuration
(setq lsp-headerline-breadcrumb-enable t)
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-show-with-cursor t)
(setq lsp-ui-doc-show-with-mouse t)
(setq lsp-lens-enable t)


;; Chain checkers with lsp checker for flycheck
(defvar-local my/flycheck-local-cache nil)

(defun my/flycheck-checker-get (fn checker property)
  (or (alist-get property (alist-get checker my/flycheck-local-cache))
      (funcall fn checker property)))

(advice-add 'flycheck-checker-get :around 'my/flycheck-checker-get)

(add-hook 'lsp-managed-mode-hook
          (lambda ()
            (when (derived-mode-p 'go-mode)
              (setq my/flycheck-local-cache '((lsp . ((next-checkers . (golangci-lint)))))))))

;; ;; Extra major modes for languages
;; (use-package caddyfile-mode
;;   :ensure t
;;   :mode (("Caddyfile\\'" . caddyfile-mode)
;;          ("caddy\\.conf\\'" . caddyfile-mode)))

;; (use-package caddyfile-mode
;;   :ensure t
;;   :mode (("\\.proto\\'" . protobuf-mode)))

(setq +latex-viewers '(zathura))
(after! lsp-python-ms
  (setq lsp-python-ms-executable (executable-find "python-language-server"))
  (set-lsp-priority! 'mspyls 1))

;; Disable minibuffer for treemacs
(setq treemacs-read-string-input 'from-minibuffer)

;; Setup format all
;; (setq +format-with-lsp nil)
;; (setq-hook! 'go-mode-hook +format-with 'goimports)
