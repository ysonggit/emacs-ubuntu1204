;;; swank-asdf.el -- ASDF support
;;
;; Authors: Daniel Barlow  <dan@telent.net>
;;          Marco Baringer <mb@bese.it>
;;          Edi Weitz <edi@agharta.de>
;;          and others 
;; License: Public Domain
;;

(in-package :swank)

#-asdf
(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :asdf))

(defslimefun operate-on-system-for-emacs (system-name operation &rest keywords)
  "Compile and load SYSTEM using ASDF.
Record compiler notes signalled as `compiler-condition's."
   (collect-notes
    (lambda ()
      (apply #'operate-on-system system-name operation keywords)
      t)))

(defun operate-on-system (system-name operation-name &rest keyword-args)
  "Perform OPERATION-NAME on SYSTEM-NAME using ASDF.
The KEYWORD-ARGS are passed on to the operation.
Example:
\(operate-on-system \"SWANK\" \"COMPILE-OP\" :force t)"
  (with-compilation-hooks ()
    (let ((operation (find-symbol operation-name :asdf)))
      (when (null operation)
        (error "Couldn't find ASDF operation ~S" operation-name))
      (apply #'asdf:operate operation system-name keyword-args))))

(defun asdf-central-registry ()
  asdf:*central-registry*)

(defslimefun list-all-systems-in-central-registry ()
  "Returns a list of all systems in ASDF's central registry."
  (mapcar #'pathname-name
          (delete-duplicates
           (loop for dir in (asdf-central-registry)
                 for defaults = (eval dir)
                 when defaults
                   nconc (mapcar #'file-namestring
                                   (directory
                                     (make-pathname :defaults defaults
                                          :version :newest
                                          :type "asd"
                                          :name :wild
                                          :case :local))))
           :test #'string=)))

(defslimefun list-all-systems-known-to-asdf ()
  "Returns a list of all systems ASDF knows already."
  ;; ugh, yeah, it's unexported - but do we really expect this to
  ;; change anytime soon?
  (loop for name being the hash-keys of asdf::*defined-systems*
        collect name))

(defslimefun list-asdf-systems ()
  "Returns the systems in ASDF's central registry and those which ASDF
already knows."
  (nunion (list-all-systems-known-to-asdf)
          (list-all-systems-in-central-registry)
          :test #'string=))

(defun asdf-module-files (module)
  (mapcan (lambda (component)
            (typecase component
              (asdf:cl-source-file
               (list (asdf:component-pathname component)))
              (asdf:module
               (asdf-module-files component))))
          (asdf:module-components module)))

(defslimefun asdf-system-files (name)
  (let* ((files (mapcar #'namestring
                        (asdf-module-files (asdf:find-system name))))
         (main-file (find name files
                          :test #'string-equal
                          :key #'pathname-name)))
    (if main-file
        (cons main-file (remove main-file files :test #'equalp))
        files)))

(defslimefun asdf-system-loaded-p (name)
  (gethash 'asdf:load-op
           (asdf::component-operation-times (asdf:find-system name))))

(defslimefun asdf-system-directory (name)
  (cl:directory-namestring
   (cl:truename
    (asdf:system-definition-pathname (asdf:find-system name)))))

;;; This looks a little bit ugly, but it needs to be fast because
;;; there can be many systems with many files
(defun system-contains-file-p (module pathname pathname-name)
  (dolist (component (asdf:module-components module))
    (typecase component
      (asdf:cl-source-file
       (when (and (equal pathname-name
                         (pathname-name
                          (asdf:component-relative-pathname component)))
                  (equal pathname (asdf:component-pathname component)))
         (return t)))
      (asdf:module
       (system-contains-file-p component pathname pathname-name)))))

(defslimefun asdf-determine-system (file)
  (loop with pathname = (pathname file)
        with pathname-name = (pathname-name pathname)
        for (nil . system) being the hash-value of asdf::*defined-systems*
        when (system-contains-file-p system pathname pathname-name)
        return (asdf:component-name system)))

(provide :swank-asdf)
