;; -*- lexical-binding: t; -*-
(defun raise-volume ()
  (interactive)
  (call-process "amixer" nil nil nil "set" "Master" "5%+"))

(defun lower-volume ()
  (interactive)
  (call-process "amixer" nil nil nil  "set" "Master" "5%-"))
(use-package exwm
  :ensure t
  :config
  (progn
    (if (getenv "USE_EXWM")
	(progn
	  (require 'exwm)
	  (require 'exwm-config)
	  (exwm-input-set-key (kbd "<XF86AudioLowerVolume>") 'lower-volume)
	  (exwm-input-set-key (kbd "<XF86AudioRaiseVolume>") 'raise-volume)
	  (exwm-input-set-key (kbd "<XF86AudioPlay>") 'emms-pause)
	  (exwm-config-default)
	  (require 'exwm-randr)

	  (setq exwm-randr-workspace-output-plist
		'(0 "eDP-1" 1 "HDMI-1"))

	  ;; (add-hook 'exwm-randr-screen-change-hook
	  ;; 	    (lambda ()
	  ;; 	      (start-process-shell-command
	  ;; 	       "xrandr" nil "xrandr --output eDP-1 --left-of HDMI-1 --auto")))
	  (exwm-randr-enable))
      (progn
	(global-set-key (kbd "<XF86AudioLowerVolume>") 'lower-volume)
	(global-set-key (kbd "<XF86AudioRaiseVolume>") 'raise-volume)
	(global-set-key (kbd "<XF86AudioPlay>") 'emms-pause)))))

