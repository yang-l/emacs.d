;;; Package --- Summary

;;; Commentary:

;;; Code:

;; optimise startup speed
(setq gc-cons-threshold most-positive-fixnum    ; set GC at beginning to speed up Emacs loading
      gc-cons-percentage 0.6
      read-process-output-max (* 16 1024 1024)
      process-adaptive-read-buffering nil)

(setq load-prefer-newer nil                     ; all default values
      native-comp-deferred-compilation t
      native-comp-jit-compilation t)

(setq package-enable-at-startup nil)            ; disable package.el

; disable at the earliest stage
;; https://lists.gnu.org/archive/html/help-gnu-emacs/2019-02/msg00318.html
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

(setq frame-resize-pixelwise t                  ; ensure turly full-screen
      window-resize-pixelwise t)

(unless (eq system-type 'darwin) (setq command-line-ns-option-alist nil))
(unless (eq system-type 'gnu/linux) (setq command-line-x-option-alist nil))

;;; early-init.el ends here
