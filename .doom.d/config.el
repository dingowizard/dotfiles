;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Dave Brda"
      user-mail-address "davebrda@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; display time in modeline
(display-time-mode 1)

;; start in fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; where to place new window when splitting
(setq evil-vsplit-window-right t)       ; new window will be on right
(setq evil-split-window-below t)        ; new window will be on bottom

;; allow choice of  buffer to open when splitting
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))

;; show preview of buffer in new window while selecting
(setq +ivy-buffer-preview t)

;;
(map! :map evil-window-map
      "SPC" #'rotate-window)

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


(setq evil-escape-key-sequence "fd"
      projectile-project-search-path '("~/lan/"))

(map! :nv "SPC /" #'comment-line) ; not really necessary since "g c c"

(use-package! auto-dim-other-buffers
  :config
  (auto-dim-other-buffers-mode t))

(use-package! mu4e
  :config
  (setq mu4e-root-maildir (expand-file-name "~/.mail/gmail")))

(use-package! zoom
  :hook (doom-first-input . zoom-mode)
  :config
  (setq zoom-size '(0.7 . 0.7)
        zoom-ignored-major-modes '(dired-mode vterm-mode help-mode helpful-mode rxt-help-mode help-mode-menu org-mode)
        zoom-ignored-buffer-names '("*doom:scratch*" "*info*" "*helpful variable: argv*")
        zoom-ignored-buffer-name-regexps '("^\\*calc" "\\*helpful variable: .*\\*")
        zoom-ignore-predicates (list (lambda () (> (count-lines (point-min) (point-max)) 20)))))
