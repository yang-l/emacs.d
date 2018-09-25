;;; Code:

(require 'lsp-mode)
(require 'ruby-mode)

(defconst lsp-ruby--get-root
  (lsp-make-traverser
   #'(lambda (dir)
       (directory-files dir nil "\\(Rakefile\\|Gemfile\\)"))))

(defun lsp-ruby--lsp-command ()
  "Generate LSP startup command."
  `("rbenv" "exec" "bundle" "exec" "solargraph" "stdio"))

(defun lsp-ruby--render-string (str)
  "Render STR with `ruby-mode' syntax highlighting."
  (ignore-errors
    (with-temp-buffer
      (ruby-mode)
      (insert str)
      (font-lock-ensure)
      (buffer-string))))

(defun lsp-ruby--initialize-client (client)
  "Initial setup for ruby LSP CLIENT."
  (lsp-provide-marked-string-renderer
   client "ruby" 'lsp-ruby--render-string))

(lsp-define-stdio-client
 lsp-ruby "ruby"
 lsp-ruby--get-root
 nil
 :initialize 'lsp-ruby--initialize-client
 :command-fn 'lsp-ruby--lsp-command)

(provide 'lsp-ruby)
;;; lsp-ruby.el ends here
