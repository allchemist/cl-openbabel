(defpackage :cl-openbabel-system
    (:use :cl :asdf))

(in-package :cl-openbabel-system)

(defsystem cl-openbabel
  :name "cl-openbabel"
  :description "OpenBabel tool for Common Lisp"
  :author "Khokhlov Ivan"
  :licence "BSD"
  :depends-on ()
  :components
  ((:file "cl-openbabel")))
