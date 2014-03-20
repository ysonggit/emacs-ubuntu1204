(require 'session)

(defun session-settings ()
  "Settings for `session'."
  (add-hook 'after-init-hook 'session-initialize-with-saveplace)

  (defun session-initialize-with-saveplace ()
    "Call `session-initialize' and add hooks for `saveplace'."
    (session-initialize)
;;;###autoload
    (defun session-settings-4-saveplace ()
      "`session' settings for `saveplace'."
      (add-hook 'find-file-hook 'save-place-find-file-hook t)
      (add-hook 'kill-emacs-hook 'save-place-kill-emacs-hook)
      (add-hook 'kill-buffer-hook 'save-place-to-alist)
      )

    (eval-after-load "saveplace"
      `(session-settings-4-saveplace))))

(eval-after-load "session"
  `(session-settings))

(provide 'session-settings)
