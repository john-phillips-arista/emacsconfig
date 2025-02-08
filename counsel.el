
(use-package counsel
  :ensure t
  :config
  (progn
    (ivy-mode)
    (setf ivy-use-virtual-buffers t)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x C-f") #'counsel-find-file)))
