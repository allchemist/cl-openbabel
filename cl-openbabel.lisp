;; OpenBabel command line tools for Common Lisp

(defpackage :cl-openbabel
    (:use :cl) (:nicknames :ob)
  (:export
   :ob-conver-string
   :ob-convert-file))

(in-package :cl-openbabel)

(defun strings (&rest things)
  (apply #'concatenate 'string
	 (mapcar #'(lambda (th)
		     (string-downcase (string th))) things)))

(defun ob-convert-string (data from to)
  "Usage: (ob-convert-string \"InChI=...\" 'inchi 'smi)"
  (let ((proc (sb-ext:run-program
	       "babel"
	       `(,(strings "-i" from)
		 ,(strings "-o" to))
	       :search t
	       :wait nil
	       :input :stream
	       :output :stream)))
    (let ((in (sb-ext:process-input proc))
	  (out (sb-ext:process-output proc)))
      (format in "~S" data)
      (close in)
      (prog1
	  (remove #\Tab (read-line out))
	(close out)
	(sb-ext:process-kill proc 9)))))
    
(defun ob-convert-file (input output)
  "Usage: (ob-convert-file \"substance.inchi\" \"substance.smi\")."
  (sb-ext:run-program
   "babel"
   (list input output)
   :search t
   :if-output-exists :supersede
   :if-input-does-not-exist :error)
  (probe-file output))
