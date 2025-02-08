
(defun load-file-in-buffer ()
  (interactive)
  (let ((fname
	 (buffer-file-name (current-buffer))))
    (load-file fname)))
(define-key emacs-lisp-mode-map (kbd "C-c l") 'load-file-in-buffer)


(defun test-file-in-buffer ()
  (interactive)
  (load-file-in-buffer)
  (ert t))

(define-key emacs-lisp-mode-map (kbd "C-c t") 'test-file-in-buffer)

(mapc (lambda (mode)
	  (add-to-list 'emacs-lisp-mode-hook mode))
	'(linum-mode
	  flycheck-mode))
