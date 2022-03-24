;;; +csharp.el -*- lexical-binding: t; -*-

(after! csharp-mode
  (map! (:localleader
         :map csharp-mode-map
         :desc "Errors" "m" #'+default/diagnostics
         (:prefix ("s" . "sessions")
          :desc "Start server" "s" #'lsp
          :desc "Stop server" "t" #'lsp-workspace-shutdown
          :desc "Reload solution" "n" #'lsp-workspace-restart)
         (:prefix ("r" . "refactorings")
          :desc "List refactorings" "l" #'omnisharp-run-code-action-refactoring
          :desc "Rename" "r" #'lsp-rename)))
  (lsp))

(add-hook! csharp-mode #'lsp)

(add-hook 'csharp-mode-hook #'flycheck-mode)
(add-hook 'csharp-mode-hook #'company-mode)
(add-hook 'csharp-mode-hook (lambda ()
                              (setq c-basic-offset 4)
                              (c-set-offset 'substatement-open 0)))

;; NOTES ON CSHARP CONFIG
;; to clear errors like 'The reference assemblies for 'The reference assemblies for framework ".NETFramework,Version=v3.5" were not found.'
;; and get intellisense working, I had to edit the 'run' script in the executable path to
;; mono_cmd = /usr/bin/mono
;; it was no longer necessary to set the executable path to run an old version of omnisharp
;; (setq omnisharp-server-executable-path "~/.emacs.d/.local/etc/omnisharp/server/v1.34.15/run")
