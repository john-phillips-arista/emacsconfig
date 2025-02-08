(require 'projectile)
(require 'f)
(require 'org)
(require 'magit)
(defvar tickets-dir "~/tickets")
(defvar tickets-name-pattern "#name#")
(defvar tickets-filename-keyword "planning")
(defvar tickets-filename-template (concat tickets-filename-keyword "-" tickets-name-pattern ".org"))

(defvar tickets-depth 2)


(defun try-list-directory (dir)
  (condition-case nil
      (directory-files dir t)
    (error nil)))

(defun ticket-regexp-from-pattern (template pattern-var)
  (concat "^" tickets-filename-keyword "\\.org" "$"))

(defun ticket-template-instantiate (template pattern-var replacement)
  (string-replace pattern-var replacement template))

(defun get-org-files-and-dirs (directory depth)
  (if (> depth tickets-depth)
      (cons nil nil)
    (let ((files (try-list-directory directory)))
      (cons
       (seq-filter
	(lambda (file)
	  (and (f-dir-p file)
	       (not (string-match ".*/\\."  file))
	       (not (string-match  ".*/\\.\\." file))))
	files)
       (seq-filter
	(lambda (file)
	  (string-match
	   (ticket-regexp-from-pattern
	    tickets-filename-template
	    tickets-name-pattern)
	   (f-filename file)))
	files)))))

(defun find-agenda-files ()
  (interactive)
  (cl-labels
      ((find-org-files
	(to-explore files)
	(cond
	 ((null to-explore) files)
	 (t
	  (let* ((depth (cdar to-explore))
		 (fname (caar to-explore))
		 (found-files (get-org-files-and-dirs fname depth))
		 (new-to-explore
		  (if (car found-files) (append (mapcar (lambda (file)
						  (cons file (1+ depth)))
						(car found-files))
					  (cdr to-explore))
		    (cdr to-explore))))
	    (find-org-files new-to-explore (append files (cdr found-files))))))))
    (find-org-files (list (cons tickets-dir 0)) nil)))

(defun show-agenda ()
  (interactive)
  (setf org-agenda-files (find-agenda-files))
  (org-agenda))

(defvar ticket-keymap
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c a") 'show-agenda)
    (define-key map (kbd "C-c n") 'tickets-open-ticket)
    map))

(defvar gitignore-contents "
**/tmp
**/src
")

(defun tickets-do-git-cmd (&rest args)
  (if (apply 'magit-run-git  (append (list "-C" (f-expand tickets-dir)) args))
      (error "unable to run git command, see *tickets-git-output*")
    (kill-buffer "*tickets-git-output*")))

(defun tickets-init-git ()
  (let ((git-dir
	 (magit-git-output  "-C" (f-expand tickets-dir) "rev-parse" "--show-toplevel")))
    (if (string-empty-p git-dir)
	(magit-run-git "-C" (f-expand tickets-dir)  "init"))))


(defun tickets-init-gitignore ()
  (interactive)
  (tickets-init-git)
  (let ((buffer (find-file-noselect (f-join tickets-dir ".gitignore"))))
    (with-current-buffer buffer
      (insert gitignore-contents)
      (save-buffer))
    (tickets-do-git-cmd "add" ".gitignore")
    (tickets-do-git-cmd "commit" "-m" "add .gitignore")))

(define-minor-mode tickets
  "Minor mode for ticket management."
  :global t
  :lighter " TK"
  :keymap ticket-keymap)

(defvar tickets-default-folders '("tmp"
				  "etc"
				  "src"))
(defun --tickets-open-ticket (name)
  (let* ((dirname (f-join tickets-dir name))
	 (ticket-fname
	  (f-join dirname (ticket-template-instantiate tickets-filename-template tickets-name-pattern name))))
    (when (not (f-exists-p dirname))
      (mkdir dirname))
    (dolist (folder tickets-default-folders)
      (mkdir (f-join dirname folder) t))
    ticket-fname))

(defun tickets-open-ticket (name)
  (interactive "sticket: ")
    (find-file (--tickets-open-ticket name)))

(provide 'tickets)
;;; tickets.el ends here.
