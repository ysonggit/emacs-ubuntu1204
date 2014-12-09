;;; dkdo-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (dkdo-mode dkdo-Edit dkdo-SetCcKeys dkdo) "dkdo"
;;;;;;  "dkdo.el" (21537 41774 987523 948000))
;;; Generated autoloads from dkdo.el

(let ((loads (get 'dkdo 'custom-loads))) (if (member '"dkdo" loads) nil (put 'dkdo 'custom-loads (cons '"dkdo" loads))))

(autoload 'dkdo-SetCcKeys "dkdo" "\
Define C-cx keys for dkdo-mode.
To invoke add this function to dkdo-mode-hook.

\(fn)" nil nil)

(autoload 'dkdo-Edit "dkdo" "\
Prepare to edit a dolist.
With non-nil PREFIXARG, prompt for the filename, and visit it.
Otherwise visit configured `dkdo-Filename' unless already editing
a dolist

\(fn PREFIXARG)" t nil)

(autoload 'dkdo-mode "dkdo" "\
A do file has top-level Sections NOW, LATER, and DONE.
Each second-level header within a section is a task. A
third-level header within a task is a subtask. The task/subtask
content starts immediately after the header prefix and includes
the remainder of the header and any content, including any lower
level sections (which are not significant to this mode).

Dated tasks start life in LATER, other tasks in NOW. Tasks are
generally shifted LATER->NOW to be worked on (this shift can be
manual or automatic) and NOW->DONE when finished. On entering
DONE tasks are prefixed with a timestamp indicating the date of
completion. Tasks can also be shifted DONE->NOW if they are being
re-visited (the DONE timestamp is removed), or NOW-LATER to be
deferred (eg pending some other event). A task shifting to LATER
is prefixed with a new due date (which is prompted for).

The intent of a subtask is to allow related items to be collected
and managed together and perhaps hidden from view util they are
being worked on. The relationship between a subtask and its
parent is not permanent and is broken at some point before the
subtask is completed. To ensure every subtask is processed it is
illegal to shift a task containing subtasks from NOW->DONE.
Instead each subtask must be shifted individually. A consequence
of this is that subtasks do not exist in DONE.

When point is on a task header or on any non-subtask content, an
operation applies to the whole task including the subtasks. When
point is on a subtask, it applies to the subtask only. When a
subtask is shifted it is detached from its parent and promoted to
a task (by adjusting its header).

An alternative approach to task breakdown is where the task
consists of a number of 'components', all of which must be
completed before the task itself can be considered completed.
This situation is handled by means of an org-mode checkboxed list
item in the task body for each component. The task header line
can indicate the number or percentage of components currently
completed, and the task may be automatically shifted to DONE
once all components have been checked (configurable). Unlike
subtasks, the components are tightly integrated into the task.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("dkdo-pkg.el") (21537 41775 93342 669000))

;;;***

(provide 'dkdo-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; dkdo-autoloads.el ends here
