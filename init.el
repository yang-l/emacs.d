;;;;  INIT
(let ((minver 24))
  (unless (>= emacs-major-version minver)
    (error "Emacs v%s or higher is required!" minver)))

(setq load-prefer-newer t)                      ; always load newest byte code
(require 'org)                                  ; init via org-mode
(org-babel-load-file
    (concat user-emacs-directory "README.org"))
