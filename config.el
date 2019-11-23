;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq company-idle-delay 0)
(require 'doom-themes)

(load-theme 'doom-molokai t)
(setq doom-font "Source Code Pro:pixelsize=16")
(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)
;; UI
;;(doom/increase-font-size 0.3)
(setq-default truncate-lines nil)
(global-whitespace-mode -1)
;;MAGIT
(add-hook 'after-save-hook 'magit-after-save-refresh-status t)

;; Undo Granularity
(advice-add 'undo-auto--last-boundary-amalgamating-number :override #'ignore)

;;TRAMP SETTINGS


;; Flycheck
(after! flycheck (setq flycheck-check-syntax-automatically '(mode-enabled idle-change)))


;; EShell
(setq-hook! 'eshell-mode-hook company-idle-delay nil)


;; Haskell
(require 'haskell-mode)
