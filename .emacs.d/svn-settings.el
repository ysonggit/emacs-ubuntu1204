;; -*- Emacs-Lisp -*-

;; Time-stamp: <2009-11-25 14:22:20 Wednesday by ahei>

(require 'psvn)
(require 'svn)
(require 'util)

(defvar svn-buffer-name "*svn-status*")

;;(if is-before-emacs-21
;;    (defalias 'svn 'svn-status)
;;  (defalias 'svn 'svn-status "简化`svn-status'命令"))

(defun svn-status-toggle-hide-unmodified-unknown ()
  "隐藏/不隐藏没有修改的文件和没加入版本控制的文件"
  (interactive)
  (let ((unmodified svn-status-hide-unmodified) (unknown svn-status-hide-unknown))
    (unless (or (and unmodified unknown) (not (or unmodified unknown)))
      (setq svn-status-hide-unmodified nil)
      (setq svn-status-hide-unknown nil))
    (svn-status-toggle-hide-unmodified)
    (svn-status-toggle-hide-unknown)))

(defun svn-status-this-dir-hide (&optional arg)
  "运行`svn-status-this-directory'后隐藏unmodified和unknown"
  (interactive "P")
  (let* ((file buffer-file-name))
    (svn-status-hide default-directory arg)
    (if (and (vc-registered file) (not (vc-up-to-date-p file)))
        (svn-status-goto-file-name (file-name-nondirectory file)))))

(defun svn-status-hide (dir &optional arg)
  "运行`svn-status'后隐藏unmodified和unknown"
  (interactive (list
                (read-directory-name "SVN status directory: " nil default-directory nil)
                current-prefix-arg))
  (svn-status dir arg)
  (setq svn-status-hide-unmodified t)
  (setq svn-status-hide-unknown t)
  (svn-status-update-buffer))

(apply-args-list-to-fun
 `(def-execute-command-on-file-command
    def-execute-command-on-current-file-command
    def-execute-command-on-current-dir-command)
  `("svn add" "svn revert" "svn rm" "svn update" "svn resolved"))

(defun visit-svn-status ()
  "访问*svn-status* buffer"
  (interactive)
  (let ((buffer (get-buffer svn-buffer-name)))
    (if buffer (switch-to-buffer buffer) (call-interactively 'svn-status-hide))))

(apply-define-key
 svn-status-mode-map
  `(("M"       svn-status-make-directory)
    ("n"       svn-status-next-line)
    ("j"       svn-status-next-line)
    ("p"       svn-status-previous-line)
    ("k"       svn-status-previous-line)
    ("<"       beginning-of-buffer)
    (">"       end-of-buffer)
    ("G"       svn-status-update-cmd)
    ("U"       svn-status-unset-all-usermarks)
    ("M"       svn-status-mark-changed)
    ("SPC"     scroll-up)
    ("E"       svn-status-toggle-edit-cmd-flag)
    ("e"       svn-status-ediff-with-revision)
    ("C-h"     svn-status-examine-parent)
    ("t"       svn-status-toggle-hide-unmodified-unknown)
    ("K"       kill-this-buffer)
    ("r"       svn-status-revert-sb)
    ("'"       switch-to-other-buffer)
    ("C-c C-j" ant)
    ("d"       svn-status-rm-sb)
    ("C-k"     svn-delete-files-sb)
    ("1"       delete-other-windows)
    ("J"       svn-dired-jump)
    ("C"       svn-status-cleanup)
    ("C-c M-r" svn-status-resolved-sb)))

(apply-define-key
 svn-log-view-mode-map
 `(("j" svn-log-view-next)
   ("k" svn-log-view-prev)
   ("d" svn-log-view-diff)
   ("e" svn-log-edit-log-entry)
   ("o" other-window)
   ("G" end-of-buffer)
   (">" end-of-buffer)
   ("<" beginning-of-buffer)
   ("Q" kill-this-buffer)))

(apply-define-key
 global-map
 `(("C-x C-v" svn-status-hide)
   ("C-x M-u" svn-update-current-file-sb)
   ("C-x V"   visit-svn-status)))

(dolist (map (list emacs-lisp-mode-map c-mode-base-map text-mode-map))
  (apply-define-key
   map
   `(("C-c M-c" svn-status-commit))))

(defun svn-resolve-conflicts-current-file ()
  (interactive)
  (svn-resolve-conflicts buffer-file-name))

(defun svn-resolved-current-file ()
  (interactive)
  (svn-status-resolved buffer-file-name))
