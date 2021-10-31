;;; Package --- Summary

;;; Commentary:

;;; Code:

;; optimise startup speed
(setq gc-cons-threshold most-positive-fixnum)   ; set GC at beginning to speed up Emacs loading

(setq load-prefer-newer noninteractive)
(setq package-enable-at-startup nil)

; disable at the earliest stage
(setq tool-bar-mode   nil
      menu-bar-mode   nil
      scroll-bar-mode nil)

(unless (or (daemonp) noninteractive)
  (setq vc-follow-symlinks t)                   ; prevent emacs to crash when opening a symbolic link
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
