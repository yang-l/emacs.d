;;; Code:

(require 'lsp-mode)
(require 'dockerfile-mode)

(defconst lsp-dockerfile--get-root
  #'(lambda () (file-name-directory buffer-file-name)))

(defun lsp-dockerfile--lsp-command ()
  "Generate LSP startup command."
  `("docker-langserver"
    "--stdio"))

(defun lsp-dockerfile--render-string (str)
  "Render STR with `dockerfile-mode' syntax highlighting."
  (ignore-errors
    (with-temp-buffer
      (dockerfile-mode)
      (insert str)
      (font-lock-ensure)
      (buffer-string))))

(defun lsp-dockerfile--initialize-client (client)
  "Initial setup for dockerfile LSP client."
  (lsp-provide-marked-string-renderer
   client "dockerfile" 'lsp-dockerfile--render-string))

(lsp-define-stdio-client
 lsp-dockerfile "dockerfile"
 lsp-dockerfile--get-root
 nil
 :initialize 'lsp-dockerfile--initialize-client
 :command-fn 'lsp-dockerfile--lsp-command)

(provide 'lsp-dockerfile)
;;; lsp-dockerfile.el ends here
