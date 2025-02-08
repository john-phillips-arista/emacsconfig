;; Refactoring tools -- replace-provctl finds all .cpp, hpp files and
;; replaces a particular name.

(defun replace-in-one-file (filename)
  (let* ((buffer-preexisting (get-file-buffer filename))
	 (buffer (if (null buffer-preexisting)
		     (find-file-noselect filename t t)
		   buffer-preexisting))
	 (close-buffer (if buffer-preexisting nil t)))
    (with-current-buffer buffer
      (goto-char (point-min))
      (cl-loop
       for found = (search-forward "ProvctlStatusCheckerThreadDelMe" nil t)
       while found
       do
       (replace-match "BackgroundProvisioner")))
    (when close-buffer
      (save-buffer buffer)
      (kill-buffer buffer))))
       

	       
(defun replace-provctl ()
  (cd "/home/john/code-projects/clover-mac")
  (vc-file-tree-walk "."
		     (lambda (x)
		       (when (or (string-match ".*\\.hpp" x)
				 (string-match ".*\\.cpp" x))
			 (message "Looking in file: %s" x)
			 (replace-in-one-file x)))))

(defun hex-one-file (filename)
  (let* ((buffer (find-file-noselect filename t t))
	 (output-file (get-buffer-create (format "HEX-%s" (f-filename filename)))))
    (with-current-buffer buffer
      (goto-char (point-min))
      (cl-loop while (< (point) (point-max))
	       do
	       (let ((hex-char (format "%02x "
				       (char-after))))
		 (message "hex: %s" hex-char)
		 (with-current-buffer output-file
		   (insert hex-char)))
	       (goto-char (1+ (point)))))))

(defun make-table-latex ()
  (interactive)
  (insert "\\begin{tabular}{|c|c|c|c|}")
  (cl-loop for i from 0 below 4 do
	   (forward-line)
	   (cl-loop for j from 0 below 3 do
		    (forward-word)
		    (insert " &"))
	   (forward-word)
	   (insert " \\\\"))
  (forward-line)
  (insert "\\end{tabular}"))

(defvar *hexl-copied-string* "")

(defun hexl-copy-selection ()
  (interactive)
  (let* ((mark (mark))
	 (old-point (point))
	 (hexes ""))
    (goto-char mark)
    (cl-loop for i = mark 
	     while (< (point) old-point)
	     do
	     (setf hexes (concat hexes (buffer-substring (point) (+ (point) 2))))
	     (hexl-forward-char 1))
    (setf *hexl-copied-string* hexes)))

(defun hexl-insert-selection ()
  (interactive)
  (hexl-insert-hex-string *hexl-copied-string*))


(defvar timer-beep "/home/john/.emacs.d/Alarm.wav")

(defun start-timer (future-time)
  (interactive "stime: ")
  (run-at-time future-time nil (lambda ()
				 (let ((proc (make-process
					      :name "alarm"
					      :command (list "aplay" timer-beep)
					      :buffer nil
					      :sentinel (lambda (proc string)))))
				   (message "[timer] Time's up!")))))

