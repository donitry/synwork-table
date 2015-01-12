;;;;;  template.lisp
;;;

(in-package #:synwork-table)

(<:augment-with-doctype "html" "" :auto-emit-p t)

(defun html-frame (context)
  (<:html
	(<:head (<:title (getf context :title))
			(<:link :rel "stylesheet" :type "text/css" :href (getf context :css))
			(<:script :type "text/javascript" :src (getf context :js)))
	(<:body
	  (<:div
		(<:h1 (getf context :title))
		(<:a :href (genurl 'home) "Home") " | "
		(<:a :href (genurl 'ctable) "Create Table") " | "
		(<:a :href (genurl 'tables) "Show Tables"))
	  (<:hr))
	(getf context :body)))

(defun create-table-form ()
  (<:form :action (genurl 'ctable/post) :method "post"
		  "Table Name:" (<:br)
		  (<:input :type "text" :name "tablename")(<:br)
		  (<:input :type "submit" :value "Create")))

;(defun edit-table-form (id-table)
 ; (

(defun tables-page (tables)
	(loop
	  for table in tables
	  collect
	  	(<:div 
		  (<:a :href 
			   (genurl 'edit-table :id (getf table :id))
			   (getf table :tablename)))))
				

