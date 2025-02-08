(use-package projectile
  :ensure t
  :config
  (progn
    (setq projectile-indexing-method 'hybrid)
    (setf projectile-cache-file (expand-file-name "~/.cache/projectile"))
    (setf projectile-known-projects-file (expand-file-name "~/.cache/projectile-bookmarks.eld"))
    (setq projectile-globally-ignored-file-suffixes
	  '(".gcov" ".ccls"))
    (setq projectile-globally-ignored-files
	  '("CMakeCache.txt" "Test.xml"))
    (setq projectile-globally-ignored-directories
	  '("CMakeCache" "CMakeFiles" ".ccls-cache" ".git" ".idea" ".tox" ".svn" ".clangd" "Testing"))
    (global-set-key (kbd "<M-s-XF86TouchpadToggle>") 'projectile-next-project-buffer)
    (add-to-list 'projectile-globally-ignored-directories
		 "*.ccls-cache")
    (add-to-list 'projectile-globally-ignored-directories
		 "*__pycache__")
    (add-to-list 'projectile-globally-ignored-directories
		 "*.cache")
    (add-to-list 'projectile-globally-ignored-directories
		 "*CMakeFiles")
    (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
    (projectile-mode +1)))
