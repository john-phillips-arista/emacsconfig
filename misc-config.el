;; -*- lexical-binding: t; -*-
(use-package iedit :ensure t)

(add-hook 'prog-mode-hook
	  'display-line-numbers-mode)

(use-package vterm
  :ensure t
  :config (progn
	    (setf vterm-shell (or
			       (executable-find "zsh")
			       (executable-find "bash")
			       (executable-find "sh")))))

(global-set-key (kbd "M-H") 'windmove-left)
(global-set-key (kbd "M-L") 'windmove-right)
(global-set-key (kbd "M-K") 'windmove-up)
(global-set-key (kbd "M-J") 'windmove-down)

(use-package org :ensure t
  :config
  (setq org-babel-load-languages
	'((emacs-lisp . t)
	  (lisp . t)
	  (C . t)
	  (scheme . t))))
(add-to-list 'org-mode-hook
	     'auto-fill-mode)
(setq org-todo-keywords
      '((sequence "TODO" "INPROGRESS" "|" "DONE" "WAITING")))
(use-package tex-mode
  :ensure t
  :config
  (add-to-list 'latex-mode-hook #'flyspell-mode))

(require 'eshell)
(require 'em-term)
(setq eshell-destroy-buffer-when-process-dies t)


(use-package all-the-icons
  :ensure t)

(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
  (add-hook 'pdf-view-mode-hook 'auto-revert-mode)
  (setf mailcap-user-mime-data
	'(((viewer . pdf-view-mode) (type . "application/pdf") (test . window-system)))))

(use-package epg :ensure t)
(use-package pinentry
  :ensure t
  :config
  (progn
    (setq epg-pinentry-mode
	  'loopback)
    (pinentry-start)))


(use-package magit :ensure t
  :config
  (progn
    (setq magit-refresh-status-buffer nil)
    ))

(setq magit-refresh-buffers nil)
(use-package treemacs-magit :ensure t
  :after treemacs magit)


;;(defvar preferred-font
;;  "-UKWN-Latin Modern Mono-normal-normal-normal-*-*-*-*-*-*-0-iso10646-1")

;; (add-to-list 'default-frame-alist `(font . ,preferred-font))
;; (set-face-attribute 'default t :font preferred-font)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'list-threads 'disabled nil)

(use-package yasnippet :ensure t
  :config (yas-global-mode 1))

(use-package popper
  :ensure t ; or :straight t
  :bind (("C-c `"   . popper-toggle)
         ("C-M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*vterm.*\\*"
          "\\*eshell\\*"
          "\\*Gemini\\*"
          "\\*Go Test\\*"
          "\\*aider.*\\*"
          "\\*Async Shell Command\\*"
          help-mode
          compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1))

;; Minor mode 
(load "buffkeys.el")
(buffkeys-mode 1)

(use-package yasnippet-snippets :ensure t)



(use-package ag :ensure t)
