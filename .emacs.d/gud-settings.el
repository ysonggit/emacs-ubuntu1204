;; -*- Emacs-Lisp -*-

;; Time-stamp: <2009-11-25 14:30:55 Wednesday by ahei>

(require 'gud)
(require 'cc-mode)

(define-key c-mode-base-map (kbd "C-c g") 'gdb)
(define-key c-mode-base-map (kbd "C-c b") 'gud-break)
(define-key c-mode-base-map (kbd "C-c B") 'gud-remove)
(define-key gud-mode-map (kbd "C-c B") 'gud-remove)
(define-key gud-mode-map (kbd "M-s") 'view)
(define-key gud-mode-map (kbd "M-m") 'comint-previous-matching-input)
(define-key gud-mode-map (kbd "M-M") 'comint-next-matching-input)
(define-key gud-mode-map (kbd "C-c r") 'gud-run)
(define-key gud-mode-map (kbd "C-c f") 'gud-finish)
(define-key gud-mode-map (kbd "M-j") 'gud-next)
(define-key gud-mode-map (kbd "M-k") 'gud-step)
(define-key gud-mode-map (kbd "M-c") 'gud-cont)
(define-key gud-mode-map (kbd "M-C") 'capitalize-word)
(define-key gud-mode-map (kbd "C-c m") 'make)

(add-hook 'gdb-mode-hook 'kill-buffer-when-shell-command-exit)
