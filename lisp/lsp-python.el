;;; Code:

(require 'lsp-mode)
(require 'python)

(defconst lsp-python--get-root
  (lsp-make-traverser #'(lambda (dir)
                          (directory-files
                           dir
                           nil
                           "\\(__init__\\|setup\\)\\.py"))))

(defun lsp-python--lsp-command ()
  "Generate LSP startup command."
  `("pyls"))

(defun lsp-python--render-string (str)
  "Render STR with `python-mode' syntax highlighting."
  (ignore-errors
    (with-temp-buffer
      (python-mode)
      (insert str)
      (font-lock-ensure)
      (buffer-string))))

(defun lsp-python--initialize-client (client)
  "Initial setup for python LSP client."
  (lsp-provide-marked-string-renderer
   client "python" 'lsp-python--render-string))

(lsp-define-stdio-client
 lsp-python "python"
 lsp-python--get-root
 nil
 :initialize 'lsp-python--initialize-client
 :command-fn 'lsp-python--lsp-command)

(provide 'lsp-python)
;;; lsp-python.el ends here
