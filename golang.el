;; -*- lexical-binding: t; -*-
(defvar do-gofmt-p t)

(defun my-go-save-hook ()
  (interactive)
  (when do-gofmt-p
    (gofmt)))

(defun my-go-mode-hook ()
  (push 'go-golint flycheck--automatically-enabled-checkers)
  (setq tab-width 4)
  (flycheck-add-next-checker 'lsp 'go-vet)  
  (add-hook 'before-save-hook
	    'my-go-save-hook))

(if (f-exists? (f-expand "~/go/bin/gopls"))
    (setf lsp-gopls-server-path
	  "~/go/bin/gopls"))

(use-package govet :ensure t)
(use-package golint :ensure t)
(setf go-mode-hook nil)
(use-package go-mode
  :ensure t
  :config
  (progn
    (let* ((go-imports-paths
            (list "/go/bin/goimports"
                  "~/go/bin/goimports"
                  "/usr/bin/goimports"))
           (found-path (or (cl-find-if (lambda (item)
                                   (f-exists? item))
                                 go-imports-paths)
                           (executable-find "goimports"))))
          (setq gofmt-command found-path))

    (add-hook 'go-mode-hook
	      'lsp)
    (add-hook 'go-mode-hook
	      #'my-go-mode-hook)))

(use-package gotest :ensure t
  :config
  (progn
    (setq-default go-test-go-command (executable-find "go"))
    (setq-default go-test-args "-coverprofile=.coverage.tmp")
    (define-key go-mode-map (kbd "C-x c") 'go-view-coverage-cur-buffer)
    (define-key go-mode-map (kbd "C-x f") 'go-test-current-file)
    (define-key go-mode-map (kbd "C-x t") 'go-test-current-test)
    (define-key go-mode-map (kbd "C-x p") 'go-test-current-project)
    (define-key go-mode-map (kbd "C-x B") 'go-test-current-benchmark)
    (define-key go-mode-map (kbd "C-x x") 'go-run)))
