;;;;;;;;;; util.lisp
;;;
(in-package #:synwork-table)

(defvar *redirect-route-table* nil)

(defun save-project-table (project-info &optional (redirect-route *redirect-route*))
  (if (project-table project-info)
	(redirect redirect-route)
	(redirect 'home)))

(defun init-datastore-table (&key
							  (port 8081)
							  (datastore 'synwork-table.redis-datastore:redis-datastore)
							  (datastore-init nil))
  (setf *datastore* (apply #'make-instance datastore datastore-init))
  (init))
  ;(start '#:synwork-table :port port :render-method 'html-frame))
