;; -*- lexical-binding: t; -*-
(defvar term-scratch-buffer-re (rx "*vterm*<scr/" (group (one-or-more digit)) ">"))
(defvar term-buffer-re (rx "*vterm*"))

(defun switch-term ()
  "Switch to a different vterm instance."
  (interactive)
  (let ((buffer
	 (completing-read
	  "Term Buffer: "
          (term-map-buffers #'identity term-buffer-re))))
    (switch-to-buffer buffer)))

(defun term-map-buffers (fun re)
  "Map FUN over buffers matching RE."
  (cl-loop for buffer in (buffer-list)
	   when (string-match re
			      (buffer-name buffer))
	   collect (funcall fun (buffer-name buffer))))

(defun term-scratch-max ()
  (apply 'max (or (term-map-buffers (lambda (bname)
                                      (car (read-from-string (match-string 1 bname))))
                                    term-scratch-buffer-re)
                  '(0))))

(defun create-term ()
  "Create a new terminal."
  (interactive)
  (let ((vterm-to-make (concat
                        "*vterm*<"
                        (completing-read
			 "New VTERM: "
			 nil
			 nil
			 nil
			 (concat "scr/" (format "%d"
                                                (1+ (term-scratch-max)))))
                        ">")))
    (vterm vterm-to-make)))

(defvar termswitch-subkey-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "s") 'switch-term)
    (define-key map (kbd "c") 'create-term)
    map))

(defvar termswitch-mode-keymap
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c t") termswitch-subkey-map)
    map))

(define-minor-mode termswitch-mode
  "Switch between VTERMS easily."
  :global t
  :keymap termswitch-mode-keymap)

(provide 'termswitch-mode)
;;; termswitch-mode.el ends here.
