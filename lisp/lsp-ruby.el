(require 'lsp-mode)
(lsp-define-stdio-client lsp-ruby "ruby"
                         (lambda () default-directory)
                         '("bundle" "exec" "language_server-ruby"))
(provide 'lsp-ruby)
