;; -*- lexical-binding: t; -*-
(defun load-local (filename)
  (let* ((home (getenv "HOME"))
	 (full-path (concat home "/.emacs.d/" filename)))
    (load full-path)))
(setf eshell-history-size 2000)
(setf ring-bell-function (lambda () nil))

;; (load-local "guix-config.el")

(setf x-alt-keysym 'meta)
(setq auth-sources '((:source "~/.authinfo.gpg")))
(load-local "locals-pre.el")
(load-local "packaging-config.el")
(use-package f :ensure t)
(require 'f)
(require 'files)
(use-package magit :ensure t)
(use-package tree-sitter :ensure t)
(use-package tree-sitter-langs :ensure t)

(push (f-expand "~/.local/bin") exec-path)

(load-local "exwm-config.el")
(load-local "lsp-config.el")
(load-local "golang.el")
(load-local "projectile-config.el")
(load-local "cxx-config.el")
(load-local "common-lisp-config.el")
(load-local "look-and-feel.el")
(load-local "misc-config.el")
(load-local "termswitch-mode.el")
(termswitch-mode +1)
(load-local "counsel.el")
(load-local "ai.el")
(load-local "python-config.el")
(display-time)
(server-start)

(load-local "locals-post.el")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil)
 '(package-vc-selected-packages
   '((claude-code :url "https://github.com/stevemolitor/claude-code.el"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
