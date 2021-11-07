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

;; straight.el & use-package
(setq straight-check-for-modifications 'live)
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(use-package straight :custom (straight-use-package-by-default t))

(eval-when-compile (require 'bind-key))
;; end of straight.el & use-package

;; load or compile elc file
(if (file-exists-p (concat user-emacs-directory "README.elc"))
    (load-file
     (concat user-emacs-directory "README.elc")); load byte-compiled init elc file
  (require 'org)                                ; initialise via org-mode
  (org-babel-load-file (concat user-emacs-directory "README.org")))

;;; init.el ends here
