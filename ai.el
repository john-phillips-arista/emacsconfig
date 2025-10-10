;; -*- lexical-binding: t; -*-

(defun get-model-and-key ()
  (let ((gemini-key (getenv "GEMINI_API_KEY"))
	(claude-key (getenv "ANTHROPIC_API_KEY")))
    (cond
     (claude-key (list 'claude claude-key))
     (gemini-key (list 'gemini gemini-key)))))

(use-package aider
  :ensure t
  :config
  (progn
    ;; For latest claude sonnet model
    (let* ((model-and-key (get-model-and-key))
	   (model (car model-and-key)))
      (cond
       ((eql model 'claude)
	(setq aider-args
	      `("--model" "sonnet"
		"--editor" ,(concat "emacsclient -s " server-name)
		"--no-auto-accept-architect")))
       ((eql model 'gemini)
	(setq aider-args
	      `("--model" "gemini"
		"--editor" ,(concat "emacsclient -s " server-name)
		"--no-auto-accept-architect")))))
    
    (push (f-expand "~/.local/bin") exec-path)
    (global-set-key (kbd "C-c a a") 'aider-transient-menu) ;; for wider screen
    ;; or use aider-transient-menu-2cols / aider-transient-menu-1col, for narrow screen
    (aider-magit-setup-transients) ;; add aider magit function to magit menu
    ;; auto revert buffer
    (global-auto-revert-mode 1)
    (auto-revert-mode 1)))

      
(use-package gptel
  :ensure t
  :config
  (let* ((model-and-key (get-model-and-key))
	 (model (car model-and-key))
	 (key (cadr model-and-key)))
    
    (cond
     ((eql model 'gemini)
      (setq
       gptel-model 'gemini-2.5-pro
       gptel-backend (gptel-make-gemini "Gemini"
					:key key
					:stream t)))
     ((eql model 'claude)
      (setq
       gptel-model 'claude-sonnet-4-20250514
       gptel-backend (gptel-make-anthropic "Claude"
					:key key
					:stream t))))

    (setq gptel-include-reasoning nil)
    (global-set-key (kbd "C-c a c") 'gptel)
    (global-set-key (kbd "C-c a m") 'gptel-menu)))


