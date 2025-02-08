(defun fix-broken-tramp ()
  "Fix a local tramp error I have been seeing.
Occasionally for whatever reason (possibly my config), tramp goes
crazy and the `file-name-handler-alist` gets 'corrupted', the tramp
autoload function gets deleted, this fixes that.  The symptoms of
the problem are that if you try to find a tramp file, it just
isn't recognized at all (CDPATH error)."
  (tramp-unload-tramp)
  (require 'tramp)
  ;; also needed to load tramp-sh.el and tramp-loaddefs.el manually with load-file.
  (tramp-register-autoload-file-name-handlers))
(defun close-remote-buffers ()
  "Close all tramp files."
  (dolist (x (tramp-list-remote-buffers))
    (kill-buffer x)))
