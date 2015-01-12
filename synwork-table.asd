(defpackage #:synwork-table-config (:export #:*base-directory*))
(defparameter synwork-table-config:*base-directory* 
  (make-pathname :name nil :type nil :defaults *load-truename*))

(asdf:defsystem #:synwork-table
  :serial t
  :description "Your description here"
  :author "Your name here"
  :license "Your license here"
  :depends-on (:RESTAS :SEXML :CL-REDIS :restas-directory-publisher)
  :components ((:file "defmodule")
  			   (:file "redis-datastore")
			   (:file "util")
			   (:file "template")
               (:file "synwork-table")))
