(defvar *project-roots*
  '("~/code-projects/" "~/grad-school/" "~/common-lisp/"))

(defvar *project-workdirs*
  '(("clover" . "~/code-projects/clover-mac/package")
    ("crypto" . "~/grad-school/cryptography")
    ("smac"  . "~/code-projects/SMAC/")
    ("macpp" . "~/code-projects/macpp/libmac++")))



(defun chpr-get-all-possible-projects ()
  (let ((all-roots))
    (cl-loop for dir in *project-roots* do
	     (let ((roots (cl-loop for item in (directory-files dir)
				   when (and (not (or (string= "." item)
						      (string= ".." item)))
					     (f-directory? (concat dir item))) collect item)))
	       (setf all-roots (append roots all-roots)))
	     finally (return all-roots))))

(defun chpr (which)
  (interactive (list
		(completing-read "project: "
				(chpr-get-all-possible-projects))))
  (let* ((project (assoc which *project-workdirs*)))
    (if project
	(cd (cdr project))
      (cl-loop for root in *project-roots*
	    do
	    (when (f-directory? (concat root which))
	      (cd (format "%s%s" root which))
	      (cl-return t))))))

(defun pcomplete/chpr ()
  "completion for chpr"
    (pcomplete-here* (chpr-get-all-possible-projects)))
