(use-package gruvbox-theme :ensure t)

(defvar my-themes
  '(gruvbox-light-medium
    gruvbox-dark-hard
    gruvbox-dark-medium
    gruvbox-light-hard
    leuven
    whiteboard))
(defun change-theme ()
  "Change to a different, random theme, from my-themes."
  (interactive)
  (cl-loop for theme in custom-enabled-themes do
           (disable-theme theme))
  (let* ((new-theme-idx (random (length my-themes)))
         (theme-name (nth new-theme-idx my-themes)))
    (load-theme theme-name t nil)
    (message (format "Changed to theme: %s" theme-name))))

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-language-environment 'utf-8)
(set-selection-coding-system 'utf-8)
(xterm-mouse-mode +1)

(change-theme)
