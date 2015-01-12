;;;; defmodule.lisp

(restas:define-policy datastore
  (:interface-package #:synwork-table.policy.datastore)
  (:interface-method-template "DATASTORE-~A")
  (:internal-package #:synwork-table.datastore)

  (define-method init ()
	"initiate the datastore")

  (define-method find-table (tablename)
	"Find the table by tablename")

  (define-method filter-data (tablename filter)
	"Filter the data by keywords")

  (define-method create-table (tablename)
	"Create the table by tablename and items")

  (define-method insert-table (tablename items)
	"Insert the data to a table")

  (define-method change-table (tablename items)
	"Change the data of the table")

  (define-method delete-data (tablename items)
	"Delete some datas by order in a table")
  
  (define-method project-table (project-info)
	"Define project table for show list")

  (define-method delete-table (tablename)
	"Delete a table by order")
  
  (define-method get-all-tables ()
	"Get All Tables for list"))

(restas:define-module #:synwork-table
  (:use #:cl #:restas #:synwork-table.datastore)
  (:export #:*redirect-route-table*
		   #:save-project-table
		   #:init-datastore-table))

(defpackage #:synwork-table.redis-datastore
  (:use #:cl #:redis #:synwork-table.policy.datastore)
  (:export #:redis-datastore))

(in-package #:synwork-table)

(defparameter *template-directory*
  (merge-pathnames #P"templates/" synwork-table-config:*base-directory*))

(defparameter *static-directory*
  (merge-pathnames #P"static/" synwork-table-config:*base-directory*))

(sexml:with-compiletime-active-layers
    (sexml:standard-sexml sexml:xml-doctype)
  (sexml:support-dtd
	(merge-pathnames "html5.dtd" (asdf:system-source-directory "sexml"))
	:<))

(mount-module -static- (#:restas.directory-publisher)
   (:url "static")
   (restas.directory-publisher:*directory* *static-directory*))

