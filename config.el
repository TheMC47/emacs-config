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
;; (setq doom-theme 'doom-one-light)

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

(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))

(defun pdf-view-save-page ()
  "Save the current page number for the document."
  (interactive)
  (let ((pdf-view-page-no (number-to-string (pdf-view-current-page))))
    (shell-command
     (concat "~/.doom.d/scripts/pdf-view-save.py "
             pdf-view-page-no " \""buffer-file-name"\" " "save"))))
(defun pdf-view-load-page ()
  "Load the saved page number for the document."
  (interactive)
  ;; .py scripts wants three arguments, so we'll send 0 as a fake page
  ;; number.
  (shell-command
   (concat "~/.doom.d/scripts/pdf-view-save.py "
           "0" " \""buffer-file-name"\" " "load"))
  (let ((pdf-view-saved-page-no
         (string-to-number
          (get-string-from-file "/tmp/pdf-view-save"))))
    (if (= pdf-view-saved-page-no -1)
        (message "No saved page number.")
      (pdf-view-goto-page pdf-view-saved-page-no))))


;;Flycheck
(after! flycheck (setq flycheck-check-syntax-automatically '(mode-enabled new-line save)) (setq flycheck-idle-change-delay '0.5))

;; UI
(setq truncate-lines nil)
(setq +evil-want-o/O-to-continue-comments nil)
;; Python
;; (add-to-list '+format-on-save-enabled-modes 'python-mode 't)
(after! (python-mode lsp-mode) (setq flycheck-checker 'python-flake8))

;; not needed after using direnv(setenv "WORKON_HOME" "/home/yecinem/anaconda3/envs")
(after! lsp-mode (setq lsp-pyls-plugins-pycodestyle-ignore '("E501")))

;; use tab indentation everywhere
(setq-default indent-tabs-mode nil)
(after! lsp-mode
  (setq lsp-enable-file-watchers nil
        lsp-enable-indentation nil
        lsp-enable-semantic-highlighting nil))
