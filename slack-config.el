(defvar switch-to-slack-last-buffer nil)
(use-package slack
  :commands (slack-start)
  :ensure t
  :config
  (progn
    (slack-register-team
     :name "cablelabs"
     :token (auth-source-pick-first-password
	     :host "cablelabs.slack.com"
	     :user "jphillips")
     :subscribed-channels '((softphy-dev softphy)))
    (define-key slack-mode-map (kbd "C-c C-c") 'slack-message-embed-mention)))

(defvar slack-buffer-of-choice "*Slack - CableLabs : softphy-dev")

(defun get-slack-team ()
  (car (slack-team-connected-list)))

(defun get-slacks ()
  (let ((slack-team (get-slack-team)))
    (remove-if-not
     (lambda (a-joined-channel)
       (string-match-p "softphy"
		       (slack-room-label a-joined-channel
					 slack-team)))
     (append (slack-team-groups slack-team)
	     (slack-team-channels slack-team)))))

(defun open-slacks ()
  (interactive)
  (dolist (slack (get-slacks))
    (slack-room-display slack (get-slack-team))))

(defun switch-to-slack ()
  (interactive)
  (if (and (equal (get-buffer slack-buffer-of-choice)
		  (current-buffer))
	   (not (null switch-to-slack-last-buffer)))
      (progn
	(switch-to-buffer switch-to-slack-last-buffer)
	(setf switch-to-slack-last-buffer nil))
    (progn
      (setf switch-to-slack-last-buffer (current-buffer))
      (switch-to-buffer slack-buffer-of-choice))))

(global-set-key (kbd "<C-s-left>") 'projectile-switch-project)
(global-set-key (kbd "<s-tab>") 'switch-to-slack)
