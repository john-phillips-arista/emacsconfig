(cl-loop for theme in '("spacemacs-theme"
			"zenburn-emacs"
			"spacemacs-theme"
			"emacs-color-theme-solarized"
			"emacs-cherry-blossom-theme")
	 do
	 (let ((location (f-expand (format "~/.emacs.d/%s" theme))))
	   (add-to-list 'load-path location)
	   (add-to-list 'custom-theme-load-path location)))
(load-theme 'zenburn t)

(load-theme 'zenburn t)

;; TODO: delete?
(defun set-theme ()
  (interactive)
  (let ((day-of-week
	 (calendar-day-of-week (calendar-current-date))))
  (cond
   ((member day-of-week '(6 0))
    (load-theme 'spacemacs-light t))
   (t (load-theme 'spacemacs-dark t)))))

