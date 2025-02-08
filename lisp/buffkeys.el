(defvar buffkeys-mode-keymap
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "M-H") 'windmove-left)
    (define-key map (kbd "M-L") 'windmove-right)
    (define-key map (kbd "M-J") 'windmove-down)
    (define-key map (kbd "M-K") 'windmove-up)))

(define-minor-mode buffkeys-mode
  "Minor mode for buffer-switching keys."
  :lighter " BK"
  :keymap buffkeys-mode-keymap)

(provide 'buffkeys-mode)
