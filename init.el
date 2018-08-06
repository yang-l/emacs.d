;;;;  INIT
(let ((minver "26.1"))
  (if (version< emacs-version minver)
    (error "Emacs v%s or higher is required!" minver)))

(setq gc-cons-threshold (* 1024 1024 64))       ; set GC at beginning to speed up Emacs loading

(require 'package)                              ; use-package bootstrap
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

(setq load-prefer-newer t)                      ; always load newest byte code
(if (file-exists-p (concat user-emacs-directory "README.elc"))
    (load-file
     (concat user-emacs-directory "README.elc")); load byte-compiled init elc file
  (require 'org)                                ; initialise via org-mode
  (org-babel-load-file
   (concat user-emacs-directory "README.org") t)
  )
