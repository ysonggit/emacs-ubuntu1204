(require 'company)
(setq company-idle-delay 0.2)
(setq company-minimum-prefix-length 1)
(setq company-begin-commands '(self-insert-command))
(define-key company-mode-map (kbd "tab") 'company-expand-top)
(dolist (hook (list 'c-mode-common 'lisp-mode-hook 'emacs-lisp-mode-hook 'java-mode-hook
                    'lisp-interaction-mode-hook 'sh-mode-hook  'awk-mode-hook 'makefile-mode-hook 'php-mode-hook 
                    'python-mode-hook  'ruby-mode-hook))
  (add-hook hook '(lambda () (company-mode t))))
