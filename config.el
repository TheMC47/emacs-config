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

;; TODO doesn't work, figure out why
;; (defun save-pdf-hook ()
;;   (if (and buffer-file-name
;;            (file-name-extension buffer-file-name)
;;            (string= (downcase (file-name-extension buffer-file-name)) "pdf"))
;;       (pdf-view-save-page)))

;; (add-hook 'kill-buffer-hook 'save-pdf-hook)
;; (add-hook 'pdf-view-mode-hook 'pdf-view-load-page)

;;Flycheck
(after! flycheck (setq flycheck-check-syntax-automatically '(mode-enabled new-line save)) (setq flycheck-idle-change-delay '0.5))

;; UI
(setq truncate-lines nil)
(setq +evil-want-o/O-to-continue-comments nil)
;; Python
;; (add-to-list '+format-on-save-enabled-modes 'python-mode 't)
;; (after! (python-mode lsp-mode) (setq flycheck-checker 'python-flake8))

;; not needed after using direnv(setenv "WORKON_HOME" "/home/yecinem/anaconda3/envs")

;; use tab indentation everywhere
(setq-default indent-tabs-mode nil)
;; (after! lsp-mode
;;   (setq lsp-enable-file-watchers nil
;;         lsp-enable-indentation nil
;;         lsp-enable-semantic-highlighting nil))
(setq lsp-idle-delay 2.0)
;; latex
(after! company-lsp
  (add-to-list 'company-lsp-filter-candidates '(texlab . t)))
(setq company-global-modes '(not latex-mode))


(defun my/dired-go-home ()
  (interactive)
  (dired "~"))

(map!
 :after dired
 :map dired-mode-map
 :n "~" #'my/dired-go-home)

;; (add-hook! 'pdf-view-before-change-page-hook
;;   (when buffer-file-name
;;     (doom-store-put buffer-file-name (pdf-view-current-page) nil "pdf-view-page")))

;; (add-hook! 'pdf-view-mode-hook
;;   (when-let (page (doom-store-get buffer-file-name "pdf-view-page"))
;;     (pdf-view-goto-page page)))

;; (setq-default window-combination-resize t)


;; (after! ivy-posframe (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center))))

;; (defun ivy-posframe-get-size ()
;;   "The default functon used by `ivy-posframe-size-function'."
;;   (list
;;    :height ivy-posframe-height
;;    :width ivy-posframe-width
;;    :min-height (or ivy-posframe-min-height (+ ivy-height 1))
;;    :min-width (or ivy-posframe-min-width (round (* (frame-width) 0.62)))))
(add-hook 'LaTeX-mode-hook #'latex-preview-pane-mode)
