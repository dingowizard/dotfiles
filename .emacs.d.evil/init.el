(setq user-emacs-directory "/home/dave/.emacs.d")

(package-initialize)
(require 'package)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (package-install 'use-package)
    (eval-when-compile (require 'use-package)))
(setq use-package-always-ensure t)

(use-package expand-region)

(use-package evil
  :config
    (evil-mode 1)
    ;; use evil-unimpaired
    (load-file "~/.emacs.d/lisp/evil-unimpaired.el")
    (evil-unimpaired-mode)

    (use-package evil-escape
      :config
	(evil-escape-mode 1)
	(setq evil-escape-key-sequence "fd"
	      evil-escape-delay 0.1))

    (use-package evil-leader
	:config
	(global-evil-leader-mode t)
	(evil-leader/set-leader "<SPC>")
	(evil-leader/set-key
	    "<SPC>" 'helm-M-x
	    "b" 'switch-to-buffer
	    "e" 'eval-last-sexp
	    "xx" 'er/expand-region
	    "h k" 'describe-key
	    "h f" 'describe-function))

    (use-package evil-surround
      :config (global-evil-surround-mode))

    (use-package evil-surround
      :config (global-evil-surround-mode)))

(use-package org)

(use-package helm
  :init
    (require 'helm-config)
    (setq helm-split-window-in-side-p t
          helm-move-to-line-cycle-in-source t)
  :config
    (helm-mode 1) ;; Most of Emacs prompts become helm-enabled
    (helm-autoresize-mode 1) ;; Helm resizes according to the number of candidates
    (global-set-key (kbd "C-x b") 'helm-buffers-list) ;; List buffers ( Emacs way )
    (define-key evil-ex-map "b" 'helm-buffers-list) ;; List buffers ( Vim way )
    (global-set-key (kbd "C-x r b") 'helm-bookmarks) ;; Bookmarks menu
    (global-set-key (kbd "C-x C-f") 'helm-find-files) ;; Finding files with Helm
    (global-set-key (kbd "M-c") 'helm-calcul-expression) ;; Use Helm for calculations
    (global-set-key (kbd "C-s") 'helm-occur)  ;; Replaces the default isearch keybinding
    (global-set-key (kbd "C-h a") 'helm-apropos)  ;; Helmized apropos interface
    (global-set-key (kbd "M-x") 'helm-M-x)  ;; Improved M-x menu
    (global-set-key (kbd "M-y") 'helm-show-kill-ring)  ;; Show kill ring, pick something to paste
    )

(use-package flycheck
  :config
    (flycheck-mode))

(use-package company
  :bind (:map company-active-map
	      ("TAB" . company-select-next)
	      ("S-TAB" . company-select-previous))
  :config
    (setq company-idle-delay 0.1))

(use-package which-key
  :config
    (which-key-mode 1)
    (setq which-key-idle-delay 0.5)
    (add-hook 'after-init-hook 'which-key-mode))

(use-package csharp-mode)

(use-package magit)

(use-package dracula-theme)

;; don't ding, flash
(setq visible-bell 1)
(tool-bar-mode -1)
(line-number-mode t)
(global-hl-line-mode t)
(scroll-bar-mode -1)
(display-line-numbers-mode 1)
;; remove trailing white space from files on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'after-init-hook 'global-company-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (evil-unimpaired powerline-evil evil-indent-textobject evil-surround evil-org evil-leader csharp-mode which-key company dracula-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
