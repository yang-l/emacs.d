(require 'lsp-mode)
(lsp-define-stdio-client lsp-python "python"
                         (lsp-make-traverser #'(lambda (dir)
                                                 (directory-files
                                                  dir
                                                  nil
                                                  "\\(__init__\\|setup\\)\\.py")))
                         '("pyls"))
(provide 'lsp-python)
