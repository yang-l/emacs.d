;;;;  INIT
(let ((minver "25.3"))
  (if (version< emacs-version minver)
    (error "Emacs v%s or higher is required!" minver)))

(setq load-prefer-newer t)                      ; always load newest byte code
(require 'org)                                  ; init via org-mode
(org-babel-load-file
    (concat user-emacs-directory "README.org") t)
