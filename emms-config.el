
(use-package emms :ensure nil
  :config
  (progn
    (setf emms-history-file "~/.cache/emms/history")
    (setf emms-score-file "~/.cache/emms/score")
    (emms-default-players)))

(require 'emms)
(require 'emms-info-libtag)
(require 'emms-info-native)
(require 'emms-info-tinytag)
(require 'emms-setup)
(setq emms-info-functions '(emms-info-libtag
			    emms-info-native
			    emms-info-tinytag))
(emms-all)

(setq emms-source-file-default-directory "~/Music/")
(global-set-key (kbd "<XF86HomePage>") 'emms)
