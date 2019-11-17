;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq company-idle-delay 0)
(require 'doom-themes)

(load-theme 'doom-molokai t)

(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)
;; UI
(doom/increase-font-size 0.3)
(setq-default truncate-lines nil)

;;MAGIT
(add-hook 'after-save-hook 'magit-after-save-refresh-status t)

;; Undo Granularity
(advice-add 'undo-auto--last-boundary-amalgamating-number :override #'ignore)

;;TRAMP SETTINGS


;; Flycheck
(setq flycheck-check-syntax-automatically '(mode-enabled idle-change))


;;HASKELL
(require 'haskell-mode)


;; C/C++
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
