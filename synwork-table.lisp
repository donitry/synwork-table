;;;; synwork-table.lisp

(in-package #:synwork-table)

;;; "synwork-table" goes here. Hacks and glory await!
;;;

(define-route home ("")
  (list :title "table"
		:body (tables-page (get-all-tables))))

(define-route tables ("tables")
  (list :title "table list"
		:body (tables-page (get-all-tables))))

(define-route ctable ("ctable")
  (list :title "Create Table"
		:body (create-table-form)))

(define-route ctable/post ("ctable" :method :post)
  (let ((table (create-table (hunchentoot:post-parameter "tablename"))))
	(if table
	  (redirect 'tables)
	  (redirect 'ctable))))

(define-route edit-table ("edit-table/:id")
  (:sift-variables (id #'parse-integer))
  (list :title "Edit Table"
		:body nil))


