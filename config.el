;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "Yecine Megdiche"
      user-mail-address "yecine.megdiche@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; test
(setq doom-font (font-spec :family "Source Code Pro" :size 16)
      doom-variable-pitch-font (font-spec :family "sans"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-palenight)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type `absolute)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Company
(setq company-idle-delay 0)

;; PDF-INFO
(setq pdf-view-resize-factor 1.1)
;; midnight-mode colors :dark grey, #012B36
(after! pdf-view-mode (setq pdf-view-midnight-colors '("dark gray" . "#012B36")))

;;Flycheck
(after! flycheck (setq flycheck-check-syntax-automatically '(mode-enabled new-line save)) (setq flycheck-idle-change-delay '0.5))

;; UI
(setq truncate-lines nil)

;; Python
(add-to-list '+format-on-save-enabled-modes 'python-mode 't)
;; not needed after using direnv(setenv "WORKON_HOME" "/home/yecinem/anaconda3/envs")
(after! lsp-mode (setq lsp-pyls-plugins-pycodestyle-ignore '("E501")))

;; use tab indentation everywhere
(setq-default indent-tabs-mode nil)
