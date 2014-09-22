;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;

;; load Org-mode from source when the ORG_HOME environment variable is set
(when (getenv "ORG_HOME")
  (let ((org-lisp-dir (expand-file-name "lisp" (getenv "ORG_HOME"))))
    (when (file-directory-p org-lisp-dir)
      (add-to-list 'load-path org-lisp-dir)
      (require 'org))))

;; load the starter kit from the `after-init-hook' so all packages are loaded
(add-hook 'after-init-hook
 `(lambda ()
    ;; remember this directory
    (setq starter-kit-dir
          ,(file-name-directory (or load-file-name (buffer-file-name))))
    ;; only load org-mode later if we didn't load it just now
    ,(unless (and (getenv "ORG_HOME")
                  (file-directory-p (expand-file-name "lisp"
                                                      (getenv "ORG_HOME"))))
       '(require 'org))
    ;; load up the starter kit
    (org-babel-load-file (expand-file-name "starter-kit.org" starter-kit-dir))))

(load-file "~/emacs24-starter-kit/DoubanMusic/douban-music-mode.el")
(autoload 'douban-music "douban-music-mode" nil t)
;; define keybind Ctrl-> for play-next
(global-set-key (kbd "C->") 'douban-music-play-next)
(global-set-key (kbd "C-<") 'douban-music-play-previous)
(global-set-key (kbd "C-?") 'douban-music-play-next-refresh)

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )
;; This is monokai-like theme
;;(load-file "~/.emacs.d/color-theme-monokai.el")
;;(color-theme-monokai)
(add-to-list 'custom-theme-load-path "~/emacs24-starter-kit/themes")
(load-theme 'monokai)

;;; init.el ends here
