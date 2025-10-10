;; -*- lexical-binding: t; -*-
(cl-loop for extra-dir in '("lisp")
	 do
	 (add-to-list 'load-path (f-expand (format "~/.emacs.d/%s" extra-dir))))
(use-package slime
  :ensure t
  :config
  (progn
    (add-to-list 'slime-contribs 'slime-repl)
    (let* ((sbcl-bin (executable-find "sbcl"))
	   (clisp-bin (executable-find "clisp")))
      (when sbcl-bin
	(push `(sbcl (,sbcl-bin)) slime-lisp-implementations))
      (when clisp-bin
	(push `(clisp (,clisp-bin)) slime-lisp-implementations)))))


(use-package paredit :ensure t
  :config (progn
	    (eval-after-load "paredit"
	      '(define-key paredit-mode-map (kbd "M-J") nil))))
(mapc (lambda (mode)
	(add-to-list 'lisp-mode-hook
		     mode))
      '(company-mode
	column-number-mode
	paredit-mode))

(defun local/lisp-before-save-hook ()
  (let ((delete-trailing-lines t))
    (delete-trailing-whitespace 0 nil))
  (lisp-indent-region (point-min) (point-max)))

(add-hook 'lisp-mode-hook
	  (lambda ()
	    (add-hook 'before-save-hook #'local/lisp-before-save-hook 0 t)))

(defun hyperspec-lookup--hyperspec-lookup-w3m (orig-fun &rest args)
  "advice function for hyperspec to use eww."
  (let ((browse-url-browser-function 'eww-browse-url))
    (apply orig-fun args)))

(advice-add 'hyperspec-lookup :around #'hyperspec-lookup--hyperspec-lookup-w3m)
