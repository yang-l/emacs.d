;;; Package --- Summary

;;; Commentary:

;;; Code:

;; optimise startup speed
(setq gc-cons-threshold most-positive-fixnum)   ; set GC at beginning to speed up Emacs loading

(setq load-prefer-newer noninteractive)
(setq package-enable-at-startup nil)            ; disable package.el

; disable at the earliest stage
(setq tool-bar-mode   nil
      menu-bar-mode   nil
      scroll-bar-mode nil)

(unless (eq system-type 'darwin)
  (setq command-line-ns-option-alist nil))
(unless (eq system-type 'gnu/linux)
  (setq command-line-x-option-alist nil))

(setq frame-inhibit-implied-resize t)
(unless (or (daemonp) noninteractive)
  (setq vc-follow-symlinks t)                   ; prevent emacs to crash when opening a symbolic link file
  (setq-default inhibit-redisplay t
                inhibit-message t)
  (add-hook 'window-setup-hook
            (lambda ()
              (setq-default inhibit-redisplay nil
                            inhibit-message nil)
              (redisplay))))

; disable 'Package cl is deprecated' message
(setq byte-compile-warnings '(not obsolete))

;;; early-init.el ends here
