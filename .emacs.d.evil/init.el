;;; init.el --- Initialization file for Emacs  -*- lexical-binding: t; -*-
;;; Commentary:
;;; Emacs Startup File --- initialization for Emacs
;;; Package --- Summary
;;; Code:

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(setq-default indent-tabs-mode nil)
(global-hl-line-mode 1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode 0)
(winner-mode 1)
(put 'narrow-to-region 'disabled nil)
(setq visible-bell t)

(require 'package)
(setq package-archives '(("melpa"     . "https://melpa.org/packages/")
                        ("elpa"      . "https://elpa.gnu.org/packages/")
                        ("repo-org"  . "https://orgmode.org/elpa/")))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package) ; unless it is already installed
  (package-refresh-contents) ; updage packages archive
  (package-install 'use-package)) ; and install the most recent version of use-package

(require 'use-package)
(setq use-package-always-ensure t)

(use-package dracula-theme)

(use-package which-key
  :config (which-key-mode 1))

(use-package general
  :after which-key
  :config
  (general-override-mode 1)

  (general-create-definer tyrant-def
    :states '(normal visual insert motion emacs)
    :prefix "SPC"
    :non-normal-prefix "C-SPC")

  (general-create-definer despot-def
    :states '(normal insert)
    :prefix "SPC"
    :non-normal-prefix "C-SPC")

  (general-define-key
    :keymaps 'key-translation-map
    "ESC" (kbd "C-g"))

  (tyrant-def
    ""     nil
    "c"   (general-simulate-key "C-c")
    "h"   (general-simulate-key "C-h")
    "u"   (general-simulate-key "C-u")
    "x"   (general-simulate-key "C-x")))

(use-package evil
  :hook (after-init . evil-mode)
  :config
  (evil-set-initial-state 'shell-mode 'normal)
  (evil-set-initial-state 'doc-view-mode 'normal)
  (evil-set-initial-state 'package-menu-mode 'normal)
  (evil-set-initial-state 'biblio-selection-mode 'motion)
  (setq doc-view-continuous t)
  :general
  (tyrant-def
    "wh"  'evil-window-left
    "wl"  'evil-window-right
    "wj"  'evil-window-down
    "wk"  'evil-window-up
    "bN"  'evil-buffer-new
    "fd"  'evil-save-and-close)
  ('motion override-global-map
    "]b"  'evil-next-buffer
    "[b"  'evil-prev-buffer))

(use-package evil-numbers
  :after evil
  :general
  ('normal "C-=" 'evil-numbers/inc-at-pt
           "C--" 'evil-numbers/dec-at-pt))

(use-package evil-surround
  :after evil
  :config (global-evil-surround-mode 1))

(use-package evil-escape
  :config
  (evil-escape-mode t)
  (setq-default evil-escape-key-sequence "fd")
  (setq-default evil-escape-delay 0.2))

(evil-mode t)

(use-package company
  :hook (after-init . global-company-mode)
  :config
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "C-n") #'company-select-next-or-abort)
  (define-key company-active-map (kbd "C-p") #'company-select-previous-or-abort)
  (setq company-frontends '(company-echo-metadata-frontend
                            company-pseudo-tooltip-unless-just-one-frontend
                            company-preview-frontend))
  (setq company-backends '((company-capf
                            company-files)
                           (company-dabbrev-code company-keywords)
                            company-dabbrev company-yasnippet)))

(use-package projectile)

(defvar narrowing-system "helm"
  "Sets the narrowing system to use - helm or ivy.")

(use-package helm
  :if (equal narrowing-system "helm")
  :hook (after-init . helm-mode)
  :config (require 'helm-config)
  :commands (helm-mini
             helm-find-files
             helm-recentf
             helm-locate
             helm-M-x
             helm-flyspell-correct)
  :general
  (tyrant-def
   "SPC" 'helm-M-x
   "bm"  'helm-mini
   "ff"  'helm-find-files
   "fr"  'helm-recentf
   "fL"  'helm-locate))

(use-package helm-flyspell
  :if (equal narrowing-system "helm")
  :commands (helm-flyspell-correct)
  :general
   (:keymaps '(flyspell-mode-map)
    :states '(normal visual)
    "zs" 'helm-flyspell-correct
    "z=" 'flyspell-buffer))

(use-package helm-projectile
  :after (projectile helm)
  :general
  (tyrant-def
   "p"   '(:ignore t :which-key "projectile")
   "pd"  'helm-projectile-dired-find-dir
   "po"  'helm-projectile-find-other-file
   "pf"  'helm-projectile-find-file
   "fp"  'helm-projectile-find-file
   "pb"  'helm-projectile-switch-to-buffer
   "bp"  'helm-projectile-switch-to-buffer))


(use-package flycheck
  :commands (flycheck-mode)
  :general
  (tyrant-def
   "e"   '(:ignore t :which-key "Errors")
   "en"  'flycheck-next-error
   "ep"  'flycheck-previous-error))

(use-package magit
  :commands (magit-status)
  :general
  (tyrant-def
   "g"   '(:ignore t :which-key "git")
   "gs"  'magit-status))

(use-package evil-magit
  :hook (magit-mode . evil-magit-init))

(use-package org
  :defer t
  :mode ("\\.org\\'" . org-mode)
  :ensure org-plus-contrib
  :init
  (defun my-org-mode-hooks ()
    (visual-line-mode)
    (display-line-numbers-mode t)
    (flyspell-mode)
    (outline-minor-mode)
    (electric-pair-mode))
  (add-hook 'org-mode-hook 'my-org-mode-hooks)
  :general
  (despot-def org-mode-map
    "me"   'org-export-dispatch
    "mt"   'org-hide-block-toggle
    "mx"   'org-babel-execute-src-block
    "mX"   'org-babel-execute-and-next
    "md"   'org-babel-remove-result)
  :config
  (if (not (featurep 'ox-bibtex))
      (require 'ox-bibtex))
  (defun org-babel-execute-and-next ()
    (interactive)
    (progn (org-babel-execute-src-block)
           (org-babel-next-src-block)))
  (setq org-highlight-latex-and-related '(entities script latex)
        org-tags-column 90)
  (add-to-list 'org-structure-template-alist
               '("<ip" "#+BEGIN_SRC ipython :session ? :results raw
  drawer\n\n#+END_SRC"
                 "<src lang=\"?\">\n\n</src>")))

(defun my-prog-mode-hook ()
  "What to do when 'prog-mode-hook'."
  (auto-fill-mode)
  (show-paren-mode)
  (whitespace-mode)
  (electric-pair-mode)
  (flycheck-mode)
  (display-line-numbers-mode))

(add-hook 'prog-mode-hook 'my-prog-mode-hook)

(provide 'init)
;;; init ends here
