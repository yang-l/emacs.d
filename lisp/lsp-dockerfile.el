(require 'lsp-mode)
(lsp-define-stdio-client lsp-dockerfile "dockerfile"
                         #'(lambda () default-directory)
                         '("docker-langserver" "--stdio"))
(provide 'lsp-dockerfile)
