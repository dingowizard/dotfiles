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
(setq doom-theme 'doom-laserwave)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/lan/org/")

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

(use-package! mu4e
  :config
  (setq mu4e-root-maildir (expand-file-name "~/.mail")))

; use mu4e for e-mail in emacs
(setq mail-user-agent 'mu4e-user-agent)

(setq mu4e-drafts-folder "/gmail/[Gmail]/Drafts")
(setq mu4e-sent-folder   "/gmail/[Gmail]/Sent Mail")
(setq mu4e-trash-folder  "/gmail/[Gmail]/Trash")

;; don't save message to Sent Messages, Gmail/IMAP takes care of this
(setq mu4e-sent-messages-behavior 'delete)

;; (See the documentation for `mu4e-sent-messages-behavior' if you have
;; additional non-Gmail addresses and want assign them different
;; behavior.)

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.

(setq mu4e-maildir-shortcuts
    '( (:maildir "/gmail/Inbox"              :key ?i)
       (:maildir "/gmail/[Gmail]/Sent Mail"  :key ?s)
       (:maildir "/gmail/[Gmail]/Trash"      :key ?t)
       (:maildir "/gmail/[Gmail]/All Mail"   :key ?a)))


(after! mu4e
  ;; (when (executable-find "w3m")
  ;;   (setq mu4e-view-prefer-html t
  ;;         mu4e-html2text-command "w3m -dump -T text/html"))
  (setq mu4e-view-show-images t)
  ;; (when (fboundp 'imagemagick-register-types)
  ;;   (imagemagick-register-types))
  (setq sendmail-program "/usr/bin/msmtp"
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from") ; , "--read-recipients")
        message-send-mail-function #'message-send-mail-with-sendmail))

(after! ivy
  ;; use fuzzy completion for ivy searches
  (setq ivy-re-builders-alist
        '((t . ivy--regex-fuzzy)))
  ;; show preview of buffer in new window while selecting
  (setq +ivy-buffer-preview t))

;; disable snipe so 's' works as in vim
(after! evil-snipe
  (evil-snipe-mode -1))

(after! org
  :config
  (setq org-agenda-files '("~/lan/todo.org")))

