(defun artist-settings ()
  "Settings for `artist-mode'."
  (defvar hl-line-mode-active nil "`hl-line-mode' active or not.")

  (make-variable-buffer-local 'hl-line-mode-active)

  (am-def-active-fun hl-line-mode hl-line-mode-active)

  (defun artist-mode-init-hook-settings ()
    "Settings for `artist-mode-init-hook'."
    (setq hl-line-mode-active (hl-line-mode-active))
    (when hl-line-mode-active
      (hl-line-mode -1)))

  (defun artist-mode-exit-hook-settings ()
    "Settings for `artist-mode-exit-hook'."
    (when hl-line-mode-active
      (hl-line-mode t)))

  (add-hook 'artist-mode-init-hook 'artist-mode-init-hook-settings)
  (add-hook 'artist-mode-exit-hook 'artist-mode-exit-hook-settings))

(eval-after-load "artist"
  `(artist-settings))

(provide 'artist-settings)
