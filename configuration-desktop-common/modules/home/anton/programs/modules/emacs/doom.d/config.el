;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; (setq doom-theme 'doom-nord-aurora)
;; (setq doom-theme 'catppuccin)
;; (setq catppuccin-flavor 'macchiato)
;; (load-theme 'catppuccin t t)
;; (catppuccin-reload)

(use-package! catppuccin-theme
  :init (setq catppuccin-flavor 'macchiato)
  :config (setq doom-theme 'catppuccin))

(setq fancy-splash-image "$DOOMDIR/images/Emacs-logo-vim.svg")

;; (set-frame-parameter nil 'alpha-background 85) ; For current frame
;; (add-to-list 'default-frame-alist '(alpha-background . 85)) ; For all new frames henceforth

(setq  user-full-name "Anton Plotnikov"
       user-mail-address "plotnikovanton@gmail.com")


;; (setq display-line-numbers-type "relative")

(setq doom-font (font-spec :family "Iosevka" :size 23))

(make-directory "~/org" t)
(setq org-directory "~/org")

;; Org roam configuration

(make-directory "~/org-roam" t)
;; (setq org-roam-database-connector 'sqlite3)
(setq org-roam-directory (file-truename "~/org-roam"))

;; (use-package! websocket
;;   :after org-roam)

;; (use-package! org-roam-ui
;;   :after org-roam ;; or :after org
;;   ;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;   ;;         a hookable mode anymore, you're advised to pick something yourself
;;   ;;         if you don't care about startup time, use
;;   ;;  :hook (after-init . org-roam-ui-mode)
;;   :config
;;   (setq org-roam-ui-sync-theme t
;;         org-roam-ui-follow t
;;         org-roam-ui-update-on-save t
;;         org-roam-ui-open-on-start t))


(setq projectile-project-search-path '("~/Workdir/" "~/Workdir/nc" "~/Workdir/blackbird-platform" ))

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
(after! lsp-mode
  ;; (setq lsp-headerline-breadcrumb-enable t)
  (setq lsp-ui-doc-enable t)
  (setq lsp-ui-doc-show-with-cursor t)
  (setq lsp-ui-doc-show-with-mouse t)
  ;; (setq lsp-lens-enable t)
  ;; (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-hover t)
  ;; (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-pylsp-plugins-flake8-enabled t))


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


(setq +latex-viewers '(zathura))

;; Disable minibuffer for treemacs
(setq treemacs-read-string-input 'from-minibuffer)


;; Configure org latex export

(after! ox-latex
  (setq Tex-command-default "LuaLaTeX")
  (setq org-latex-compiller "lualatex")
  (add-to-list 'org-latex-classes
               '("org-note"
                 "\\documentclass[11pt]{report}
% \\renewcommand\\maketitle{}
\\usepackage[russian,english]{babel}
\\babelfont{rm}{Liberation Serif}
\\babelfont{sf}{Liberation Sans}
\\usepackage[a4paper,margin=1.5cm,left=2cm]{geometry}

\\usepackage{listings}
\\usepackage{xcolor}

\\definecolor{codegreen}{rgb}{0,0.6,0}
\\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\\definecolor{codepurple}{rgb}{0.58,0,0.82}
\\definecolor{backcolour}{rgb}{0.95,0.95,0.92}

\\lstdefinestyle{mystyle}{
    backgroundcolor=\\color{backcolour},
    commentstyle=\\color{codegreen},
    keywordstyle=\\color{magenta},
    numberstyle=\\tiny\\color{codegray},
    stringstyle=\\color{codepurple},
    basicstyle=\\ttfamily\\footnotesize,
    breakatwhitespace=false,
    breaklines=true,
    captionpos=b,
    keepspaces=true,
    numbers=left,
    numbersep=5pt,
    showspaces=false,
    showstringspaces=false,
    showtabs=false,
    tabsize=2
}

\\lstset{style=mystyle}
"
                 ("\\section*{%s}" . "\\section*{%s}")
                 ("\\subsection*{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection*{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph*{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph*{%s}" . "\\subparagraph*{%s}")))
  (setq org-latex-default-class "org-note")
  (setq org-latex-listings t)
  (setq org-latex-toc-command "")
  ;; (setq org-latex-pdf-process
  ;;       '("lualatex -shell-escape -interaction nonstopmode %f"
  ;;         "lualatex -shell-escape -interaction nonstopmode %f"))
  (setq org-latex-default-packages-alist
        '(;; ("russian,english"   "babel"   t)
          (""     "graphicx"  t)
          (""     "longtable" nil)
          (""     "wrapfig"   nil)
          (""     "rotating"  nil)
          ("normalem" "ulem"  t)
          (""     "amsmath"   t)
          (""     "amssymb"   t)
          (""     "capt-of"   nil)
          (""     "hyperref"  nil))
        )
  )

(setq plantuml-executable-path "/etc/profiles/per-user/anton/bin/plantuml")
(setq plantuml-default-exec-mode 'executable)
