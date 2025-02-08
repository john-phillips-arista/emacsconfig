(add-to-list 'load-path (f-expand "~/.emacs.d/lisp/geiser/elisp/"))
(add-to-list 'load-path (f-expand "~/.emacs.d/lisp/geiser-guile/"))
(require 'geiser-guile)
(require 'geiser)
(require 'geiser-guile)
(use-package geiser
  :ensure nil
  :config
  (progn
    (setq geiser-active-implementations '(guile))
    (setq geiser-scheme-implementation '(guile))
    (setf geiser-guile-binary (executable-find "guile"))))
(use-package geiser-guile :ensure t)
