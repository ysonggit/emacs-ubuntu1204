;;(require 'org)
(defun org-settings ()
  "Settings for `org'."

  (defun org-settings-4-emaci ()
    "`org-mode' settings for `emaci'."
    (emaci-add-key-definition "n" 'outline-next-visible-heading
                              '(eq major-mode 'org-mode))
    (emaci-add-key-definition "p" 'outline-previous-visible-heading
                              '(eq major-mode 'org-mode)))

  (eval-after-load "emaci"
    `(org-settings-4-emaci)))

(eval-after-load "org"
  `(org-settings))
(define-key muse-mode-map (kbd "<tab>") 'org-cycle)
(define-key muse-mode-map (kbd "<S-iso-lefttab>") 'org-shifttab)
(setq org-hide-leading-stars t)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done 'time)

(provide 'org-settings)
