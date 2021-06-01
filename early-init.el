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

; disable 'Package cl is deprecated' message
(setq byte-compile-warnings '(not obsolete))

;;; early-init.el ends here
