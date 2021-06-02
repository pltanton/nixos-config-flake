;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq gc-cons-threshold 1000000000)
(setq read-process-output-max (* 3 (* 1024 1024))) ;; 1mb
(setq redisplay-dont-pause t)


(setq user-full-name "Anton Plotnikov"
      user-mail-address "plotnikovanton@gmail.com")

(setq doom-theme 'doom-one)

(setq display-line-numbers-type "relative")

(setq doom-font (font-spec :family "Iosevka" :size 29))
(setq org-directory "~/Nextcloud/Org/")
(setq projectile-project-search-path '("~/Workdir/" "~/Workdir/intellectokids" "~/Workdir/blackbird-platform" ))

(defun my-open-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source "light green")  ; org-agenda source
    (cfw:org-create-file-source "family" "~/Nextcloud/Org/gcal-family.org" "royal blue")  ; other org source
    (cfw:org-create-file-source "personal" "~/Nextcloud/Org/gcal-Personal.org" "light slate blue")  ; other org source
                                        ; (cfw:ical-create-source "gcal" "https://..../basic.ics" "IndianRed") ; google calendar ICS
    )))

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
  ;; (set-face-attribute 'org-level-1 nil
  ;;                     :height 1.2
  ;;                     :weight 'normal)
  ;; (set-face-attribute 'org-level-2 nil
  ;;                     :height 1.0
  ;;                     :weight 'normal)
  ;; (set-face-attribute 'org-level-3 nil
  ;;                     :height 1.0
  ;;                     :weight 'normal)
  ;; (set-face-attribute 'org-level-4 nil
  ;;                     :height 1.0
  ;;                     :weight 'normal)
  ;; (set-face-attribute 'org-level-5 nil
  ;;                     :weight 'normal)
  ;; (set-face-attribute 'org-level-6 nil
  ;;                     :weight 'normal)
  ;; (set-face-attribute 'org-document-title nil
  ;;                     :height 1.75
  ;;                     :weight 'bold)
  ;; (setq
  ;;  org-bullets-bullet-list '("⁖")
  ;;  org-ellipsis " ... "))
  )

(setq org-gcal-client-id "434844487513-bh857v7fbof2jmuodtt0mt7fd2dlilvk.apps.googleusercontent.com"
      org-gcal-client-secret "eXdqPJzZo_avwzPIjCdfdHVX"
      org-gcal-fetch-file-alist '(("plotnikovanton@gmail.com" .  "~/Nextcloud/Org/gcal-personal.org")
                                  ("3u0e78960q1jdjgi7tvd15iqg8@group.calendar.google.com" .  "~/Nextcloud/Org/gcal-family.org")))

(map! :ne "C-/" #'comment-or-uncomment-region)

(set-popup-rule! "^\\*Org Agenda" :side 'bottom :size 0.90 :select t :ttl nil)
(set-popup-rule! "^CAPTURE.*\\.org$" :side 'bottom :size 0.90 :select t :ttl nil)
(set-popup-rule! "^\\*org-brain" :side 'right :size 1.00 :select t :ttl nil)

;; Local prodject snippets

(setq +snippets-dir "~/.emacs.d/snippets")
(defun add-project-snippets ()
  (let ((dir (expand-file-name "snippets" projectile-project-root)))
    (when (file-directory-p dir)
      (add-to-list 'yas-snippets-dir dir))))

(add-hook 'projectile-after-switch-project-hook #'add-project-snippets)

(require 'quail)
(setq yas-triggers-in-field t)


;; Russian language support
(load-file "~/.doom.d/cyrillic-dvorak.el")
(setq default-input-method "cyrillic-dvorak")

(after! ispell
        (setenv "LANG" "en_US")
        (ispell-set-spellchecker-params)
        (ispell-hunspell-add-multi-dic "ru_RU,en_GB,en_US")
        (setq ispell-dictionary "ru_RU,en_GB,en_US")
)

;; Extra major modes for languages
(use-package caddyfile-mode
  :ensure t
  :mode (("Caddyfile\\'" . caddyfile-mode)
         ("caddy\\.conf\\'" . caddyfile-mode)))

(use-package caddyfile-mode
  :ensure t
  :mode (("\\.proto\\'" . protobuf-mode)))

(setq +latex-viewers '(zathura))
