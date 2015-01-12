;;;;;;;;;; redis-datastore.lisp
;;;

(in-package #:synwork-table.redis-datastore)

(defclass redis-datastore ()
  ((host :initarg :host :initform #(127 0 0 1) :accessor host)
   (port :initarg :port :initform 6379 :accessor port)))

(defmethod datastore-init ((datastore redis-datastore)))

(defun serialize-list (list)
  (with-output-to-string (out)
	(print list out)))

(defun deserialize-list (string)
  (let ((read-eval nil))
	(read-from-string string)))

(defun make-key (prefix suffix)
  (format nil "~a:~a" (symbol-name prefix) suffix))

(defmethod datastore-project-table ((datastore redis-datastore) project-info)
  (with-connection (:host (host datastore)
					:port (port datastore))
	(when project-info
	  (red-hset (make-key :pro (getf project-info :project-id)) (make-key :submitter (getf project-info :submitter-id)) (getf project-info :project-name))
	  t )))


(defmethod datastore-find-table ((datastore redis-datastore) tablename)
  (with-connection (:host (host datastore)
					:port (port datastore))
	(let ((table-id (red-get (make-key :tablename tablename))))
	  (when table-id
		(deserizlize-list (red-get (make-key :table table-id)))))))

(defmethod datastore-create-table ((datastore redis-datastore) tablename)
  (with-connection (:host (host datastore)
					:port (port datastore))
	(unless (datastore-find-table datastore tablename)
	  (let* ((id (red-incr :table-ids))
			 (record (list :id id
						   :tablename tablename
						   :ctime (get-universal-time))))
		(red-set (make-key :table id) (serialize-list record))
		(red-set (make-key :tablename tablename) id)
		tablename))))

(defun get-all-tables/internal ()
  (let ((keys (red-keys (make-key :table "*"))))
	(loop for key in keys
		collect (deserialize-list (red-get key)))))

(defun get-table-row/internal (table-id)
  (let ((keys (red-hkeys (make-key :table-data table-id))))
	(loop for key in keys
	    collect (deserialize-list (red-hgetall key)))))

(defun sort-tables (tables)
  (sort tables #'>
		:key #'(lambda (table) (getf table :ctime))))

(defmethod datastore-get-all-tables ((datastore redis-datastore))
  (with-connection (:host (host datastore)
					:port (port datastore))
	(sort-tables (get-all-tables/internal))))
