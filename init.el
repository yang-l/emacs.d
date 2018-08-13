;;;;  INIT
(let ((minver "26.1"))
  (if (version< emacs-version minver)
    (error "Emacs v%s or higher is required!" minver)))

;; Optimise startup speed
(setq gc-cons-threshold (* 1024 1024 64))       ; set GC at beginning to speed up Emacs loading

; https://github.com/Kaali/vj-emacs-0x12
(defvar file-name-handler-alist-old file-name-handler-alist)
(setq file-name-handler-alist nil)              ; remove file handler during startup
(add-hook 'after-init-hook
          #'(lambda ()
              (run-with-idle-timer
               1 nil
               #'(lambda () (setq file-name-handler-alist file-name-handler-alist-old)))
              ) t)
;; end of optimise startup speed

(require 'package)                              ; use-package bootstrap
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
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
