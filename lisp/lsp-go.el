;;; Code:

(require 'lsp-mode)
(require 'go-mode)

(defconst lsp-go--get-root
  (lsp-make-traverser #'(lambda (dir)
                          (directory-files
                           dir
                           nil
                           "main.go"))))

(defun lsp-go--lsp-command ()
  "Generate LSP startup command."
  `("go-langserver" "-mode=stdio" "-gocodecompletion"))

(defun lsp-go--render-string (str)
  "Render STR with `go-mode' syntax highlighting."
  (ignore-errors
    (with-temp-buffer
      (go-mode)
      (insert str)
      (font-lock-ensure)
      (buffer-string))))

(defun lsp-go--initialize-client (client)
  "Initial setup for Go LSP client."
  (lsp-provide-marked-string-renderer
   client "go" 'lsp-go--render-string))

(lsp-define-stdio-client
 lsp-go "go"
 lsp-go--get-root
 nil
 :initialize 'lsp-go--initialize-client
 :command-fn 'lsp-go--lsp-command
 :ignore-regexps '("^langserver-go: reading on stdin, writing on stdout$"))

(provide 'lsp-go)
;;; lsp-go.el ends here
