(require 'lsp-mode)
(lsp-define-stdio-client lsp-bash "bash"
                         #'(lambda () default-directory)
                         '("bash-language-server" "start"))
(provide 'lsp-bash)
