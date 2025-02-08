(defvar tag-finder-code-dir "~/code-projects")
(defun find-tags ()
  (seq-filter (lambda (item)
		(file-exists-p (concat item "/TAGS")))
	      (seq-filter (lambda (item) (file-directory-p item))
			  (mapcar (lambda (dir) (concat tag-finder-code-dir "/" dir))
				  (seq-filter (lambda (item) (not (string-prefix-p "." item)))
					      (directory-files tag-finder-code-dir))))))

(defun refresh-tags ()
  (dolist
      (tagdir (find-tags))
    (shell-command
     (concat "cd " tagdir "; etags $(find " tagdir " -name \"*.[c,h]\")"))))


