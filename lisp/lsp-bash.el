;;; Code:

(require 'lsp-mode)
(require 'sh-script)

(defconst lsp-bash--get-root
  #'(lambda () (file-name-directory buffer-file-name)))

(defun lsp-bash--lsp-command ()
  "Generate LSP startup command."
  `("bash-language-server"
    "start"))

(defun lsp-bash--render-string (str)
  "Render STR with `sh-mode' syntax highlighting."
  (ignore-errors
    (with-temp-buffer
      (sh-mode)
      (insert str)
      (font-lock-ensure)
      (buffer-string))))

(defun lsp-bash--initialize-client (client)
  "Initial setup for bash LSP client."
  (lsp-provide-marked-string-renderer
   client "bash" 'lsp-bash--render-string))

(lsp-define-stdio-client
 lsp-bash "bash"
 lsp-bash--get-root
 nil
 :initialize 'lsp-bash--initialize-client
 :command-fn 'lsp-bash--lsp-command)

(provide 'lsp-bash)
;;; lsp-bash.el ends here
