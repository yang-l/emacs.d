;;;;  INIT
(let ((minver 24))
  (unless (>= emacs-major-version minver)
    (error "Emacs v%s or higher is required!" minver)))

(setq load-prefer-newer t)                      ; always load newest byte code
(org-babel-load-file "~/.emacs.d/README.org")   ; org-mode style init
