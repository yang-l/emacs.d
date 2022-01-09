;;; Package --- Summary

;;; Commentary:

;;; Code:

;; optimise startup speed
(setq gc-cons-threshold most-positive-fixnum)   ; set GC at beginning to speed up Emacs loading

(setq load-prefer-newer t)
(setq package-enable-at-startup nil)            ; disable package.el

(when (and (fboundp 'native-comp-available)
        (native-comp-available))
  (when (boundp 'comp-deferred-compilation)
    (setq comp-deferred-compilation t)))        ; native-comp

; disable at the earliest stage
(setq tool-bar-mode   nil
      menu-bar-mode   nil
      scroll-bar-mode nil)

(unless (eq system-type 'darwin)
  (setq command-line-ns-option-alist nil))
(unless (eq system-type 'gnu/linux)
  (setq command-line-x-option-alist nil))

;;; early-init.el ends here
