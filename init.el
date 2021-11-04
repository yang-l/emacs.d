;;; Package --- Summary

;;; Commentary:

;;; Code:

;; version check
(let ((minver "27.1"))
  (if (version< emacs-version minver)
    (error "Emacs v%s or higher is required!" minver)))

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

;; silence emacs startup
; disable minibufer welcome message
(advice-add #'display-startup-echo-area-message :override #'ignore)
(setq inhibit-startup-screen t                  ; no splash
      initial-scratch-message nil
      inhibit-startup-echo-area-message nil
      initial-major-mode 'fundamental-mode
      inhibit-default-init t)                   ; skip default.el

;; setup use-package
; add existing libraries to load-path
(let ((default-directory
        (concat user-emacs-directory
                (convert-standard-filename "elpa/"))))
  (if (not (file-exists-p default-directory))
    (make-directory default-directory t))
  (normal-top-level-add-subdirs-to-load-path))

; (package-initialize) from package.el is slow, and try to avoid it when possible
; only install use-package when not found
(unless (locate-library "use-package")
  (require 'package)                            ; use-package bootstrap
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
  (package-initialize)
  (unless (package-installed-p 'use-package)
    (package-refresh-contents)
    (message "[Emacs Init] Installing `use-package' ... ")
    (package-install 'use-package))
  )

(eval-when-compile
  (require 'use-package))
;; end of setup use-package

;; load or compile elc file
(if (file-exists-p (concat user-emacs-directory "README.elc"))
    (load-file
     (concat user-emacs-directory "README.elc")); load byte-compiled init elc file
  (require 'org)                                ; initialise via org-mode
  (org-babel-load-file
   (concat user-emacs-directory "README.org") t)
  )

;;; init.el ends here
