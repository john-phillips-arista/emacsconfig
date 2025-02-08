(setenv "WORKON_HOME" "~/.virtualenvs")
(use-package pyvenv :ensure t
  :config
  (setq pyvenv-virtualenvwrapper-python "python3"))
(use-package python
  :config
  (progn
    (cl-loop for hook in '(linum-mode column-number-mode lsp company auto-fill-mode) do
	     (add-hook 'python-mode-hook hook))))
(setq python-shell-interpreter "python3"
      python-shell-interpreter-args ""
      python-shell-prompt-detect-failure-warning nil)

