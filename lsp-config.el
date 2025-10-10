;; -*- lexical-binding: t; -*-
(use-package lsp-mode
  :ensure t
  :config
  (progn
    (setq lsp-enable-indentation nil)
    (setq lsp-enable-on-type-formatting nil)))
(use-package lsp-ui :ensure t)
(use-package lsp)
(use-package company :ensure t)
