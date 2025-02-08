(define-minor-mode
  my-c-mode
  "C mode for working on softphy"
  nil
  " my-c-mode"
  '()
  :global nil
  (if my-c-mode
      (progn
		(message "eval")
	    (setq tab-width 4)
	    (setq indent-tabs-mode t)
	    (setq tab-stop-list '(0 4 8)))))
	
