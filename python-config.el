;; -*- lexical-binding: t; -*-

(defun my/python-flycheck-setup ()
  "Set up Flycheck for Python with virtualenv support."
  ;; This function finds and activates the virtualenv for the current project.
  (flycheck-add-next-checker 'lsp 'python-mypy)
  (ruff-format-on-save-mode +1))


(use-package python
  :config
  (progn
    (with-eval-after-load 'flycheck
      (with-eval-after-load 'lsp-mode
	(add-hook 'python-mode-hook 'my/python-flycheck-setup)))
      (add-hook 'python-mode-hook 'flycheck-mode))
    (with-eval-after-load 'lsp-mode
      (add-hook 'python-mode-hook 'lsp)))

(use-package flycheck :ensure t)
(use-package ruff-format :ensure t)
;; fix the flycheck checker
(flycheck-define-checker python-mypy
  "Mypy syntax and type checker.  Requires mypy>=0.730.

See URL `https://mypy-lang.org/'."
  :command ("python3" "-m" "mypy"
            "--show-column-numbers"
            "--no-pretty"
            (config-file "--config-file" flycheck-python-mypy-config)
            (option "--cache-dir" flycheck-python-mypy-cache-dir)
            (option "--python-executable" flycheck-python-mypy-python-executable)
            source-original)
  :error-patterns
  ((error line-start (file-name) ":" line (optional ":" column)
          ": error:" (message) line-end)
   (warning line-start (file-name) ":" line (optional ":" column)
            ": warning:" (message) line-end)
   (info line-start (file-name) ":" line (optional ":" column)
         ": note:" (message) line-end))
  :working-directory flycheck-python-find-project-root
  :modes (python-mode python-ts-mode)
  ;; Ensure the file is saved, to work around
  ;; https://github.com/python/mypy/issues/4746.
  :predicate flycheck-buffer-saved-p)
