
(when (>= 21 emacs-major-version)
  (defalias 'move-beginning-of-line 'beginning-of-line)
  (defalias 'move-end-of-line       'end-of-line))

;;;###autoload
(defun am-add-hooks (hooks function &optional append local)
  "Call `add-hook' on hook list HOOKS use arguments FUNCTION, APPEND, LOCAL.

HOOKS can be one list or just a hook."
  (if (listp hooks)
      (mapc
       `(lambda (hook)
          (add-hook hook ',function append local))
       hooks)
    (add-hook hooks function append local)))

;;;###autoload
(defun am-intern (&rest strings)
  "`intern' use STRINGS."
  (intern
   (apply
    'concat
    (mapcar
     (lambda (element)
       (if (stringp element) element (symbol-name element)))
     strings))))

;;;###autoload
(defun am-variable-is-t (symbol)
  "Return SYMBOL's value is t or not."
  (and (boundp symbol) (symbol-value symbol)))

;;;###autoload
(defmacro am-def-active-fun (symbol &optional fun-name)
  "Make definition of function judge variable is active or not."
  `(defun ,(if fun-name fun-name symbol) ()
     ,(concat "`" (symbol-name symbol) "' is t or not.")
     (am-variable-is-t ',symbol)))

;;;###autoload
(defun am-forward-word-or-to-word ()
  "`forward-word' or `forward-to-word'.
If after excute `forward-to-word', current position
is at next line, then rollback and excute `forward-word'"
  (interactive)
  (let ((noo (line-number-at-pos)) no)
    (save-excursion
      (forward-to-word 1)
      (setq no (line-number-at-pos)))
    (if (> no noo)
        (forward-word)
      (forward-to-word 1))))

(provide 'ahei-misc)

;;; ahei-misc.el ends here
