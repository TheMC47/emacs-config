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
(setq-default truncate-lines nil)
(setq doom-line-numbers-style 'relative)
(global-whitespace-mode -1)
;;MAGIT
(add-hook 'after-save-hook 'magit-after-save-refresh-status t)

;; Undo Granularity
(advice-add 'undo-auto--last-boundary-amalgamating-number :override #'ignore)

;;TRAMP SETTINGS


;; Flycheck
(after! flycheck (setq flycheck-check-syntax-automatically '(mode-enabled idle-change)))

;; pdf-tools
(setq pdf-view-resize-factor 1.1)

;; EShell
(setq-hook! 'eshell-mode-hook company-idle-delay nil)

;; Irony
(setq irony-server-install-prefix '"/usr/")
 (add-hook 'c++-mode-hook 'irony-mode)
 (add-hook 'c-mode-hook 'irony-mode)
 (add-hook 'objc-mode-hook 'irony-mode)

 (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Haskell
(add-hook 'haskell-mode-hook #'hindent-mode)
(setq haskell-stylish-on-save t)

(setq haskell-mode-stylish-haskell-path "brittany")

;; Java
;; (require 'eclim)
;; (setq eclimd-autostart t)
;; (global-eclim-mode)
;; (custom-set-variables
;;   '(eclim-eclipse-dirs '("/usr/lib/eclipse")))
;; (setq help-at-pt-display-when-idle t)
;; (setq help-at-pt-timer-delay 0.1)
;; (help-at-pt-set-timer)

;; (after! (company company-emacs-eclim)
;;   (company-emacs-eclim-setup))
