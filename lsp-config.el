(use-package lsp-mode
  :ensure t
  :config
  (progn
    (setq lsp-clients-clangd-executable "/usr/bin/clangd-19")
    (setf lsp-clangd-binary-path "/usr/bin/clangd-19")
    (setq lsp-enable-indentation nil)
    (setq lsp-enable-on-type-formatting nil)))
(use-package lsp-ui :ensure t)
(use-package lsp
  :config (progn
	    (setf lsp-session-file (expand-file-name "~/.cache/.lsp-session-v1"))))
(use-package company :ensure t)
(push 'ccls lsp-disabled-clients)
