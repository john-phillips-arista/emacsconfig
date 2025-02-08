(defun find-c-files (directory)
  (directory-files-recursively directory ".[hc]\\(pp\\)?$"))

;; (defun parse-class (class-name)
;;   (string-match "^\\(?:\\([a-zA-Z]*\\)::\\)*\\([a-zA-Z]+\\)$" class-name))

(defvar namespace-regex
  "\\([a-zA-Z0-8_]+\\)::")


(defun parse-namespaces (class-path)
  (let ((namespaces nil)
	(offset 0))
  (while (string-match namespace-regex class-path offset)
    (push (match-string 1 class-path) namespaces)
    (setf offset (match-end 0)))
  (list (reverse namespaces) offset)))

(defun parse-class (class-path)
  (destructuring-bind (namespaces class-offset) (parse-namespaces class-path)
    (append namespaces (list (substring class-path class-offset)))))

(defclass cpp-class ()
  ((classpath :initarg :classpath)
   (parsed-class-list :initform nil)))


(cl-defmethod initialize-instance :after ((this cpp-class) &rest)
  (oset this parsed-class-list (parse-class (oref this classpath))))

(cl-defmethod cpp-class-name-with-prefix ((this cpp-class) prefix-list suffix)
  (concat
   (string-join
    (append
     prefix-list
     (oref this parsed-class-list)) "/") suffix))

(cl-defmethod cpp-class-classname ((this cpp-class))
  (cpp-class-name-with-prefix this (list (projectile-project-root)
					 "src")
			      ".cpp"))

(cl-defmethod cpp-class-hdrname ((this cpp-class))
  (cpp-class-name-with-prefix this (list (projectile-project-root)
					 "include")
			      ".hpp"))

  

(defun class-to-relative-path (class-path)
  (let ((path-base 
	 (string-join (parse-class class-path)
		      "/")))
    (concat path-base ".cpp")))

(defun rename-headers-of-file (filename)
  (let ((buffer
	 (find-file-noselect filename)))
    (with-current-buffer buffer
      (save-excursion
	(goto-char (point-min))
	(while (not (= (buffer-end 1) (point)))
	  (let ((line (buffer-substring
		       (line-beginning-position)
		       (line-end-position))))
	    (if (not (null (string-match
			    "^#include \"\\.\\./include/legacy/\\([^\"]*\\)\""
			    line)))
		(let ((to-replace (match-string 1 line)))
		  (set-text-properties 0 (1- (length to-replace)) nil to-replace)
		  (message "Matched %s" to-replace)
		  (let ((newtext
			 (replace-match (concat "#include \"smac/legacy/" to-replace "\"")
					nil
					nil
					line)))
		    (kill-line)
		    (insert newtext)
		    (forward-line)))
	      (forward-line))))))))



(defun rename-unique-pointers (buffer)
  (with-current-buffer buffer
    (save-excursion
      (dolist (search-item (list "unique_ptr<Buffer>"
				 "unique_ptr<daabus::Buffer>"))
	(goto-char (point-min))
	(let ((searched nil))
	  (do ((searched (search-forward search-item nil t)
			 (search-forward search-item nil t)))
	      ((null searched))
	    (replace-match "daabus::BufferPointer")))))))

(defun rename-management-message-pointers ()
  (interactive)
  (let ((all-management-message-files
	 (append 
	  (find-c-files "~/code-projects/SMAC/src/smac/management_messages/")
	  (find-c-files "~/code-projects/SMAC/include/smac/management_messages/"))))
    (dolist (filename all-management-message-files)
      (rename-unique-pointers (find-file-noselect filename)))))

(defun rename-pointers-in-current-buffer ()
  (interactive)
  (rename-unique-pointers (current-buffer)))

