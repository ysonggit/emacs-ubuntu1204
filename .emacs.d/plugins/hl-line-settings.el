;; -*- Emacs-Lisp -*-

;; Time-stamp: <2009-11-25 14:20:52 Wednesday by ahei>

;; 高亮当前行
(dolist (hook `(find-file-hook help-mode-hook Man-mode-hook log-view-mode-hook
                               compilation-mode-hook gdb-mode-hook lisp-interaction-mode-hook
                               browse-kill-ring-mode-hook completion-list-mode-hook hs-hide-hook
                               inferior-ruby-mode-hook custom-mode-hook Info-mode-hook text-mode-hook
                               dired-mode-hook package-menu-mode-hook diff-mode-hook emacs-lisp-mode-hook
                               ibuffer-mode-hook data-debug-hook debugger-mode-hook svn-log-view-mode-hook))
  (add-hook hook
            '(lambda ()
               (if (not (memq major-mode '(image-mode)))
                   (hl-line-mode t)))))
