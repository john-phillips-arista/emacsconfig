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
;; (tre-esitter-require 'cxx)
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
(display-time)
(server-start)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(connection-local-criteria-alist
   '(((:application eshell) eshell-connection-default-profile)
     ((:application tramp)
      tramp-connection-local-default-system-profile
      tramp-connection-local-default-shell-profile)))
 '(connection-local-profile-alist
   '((eshell-connection-default-profile (eshell-path-env-list))
     (tramp-connection-local-darwin-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o"
					"pid,uid,user,gid,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
					"-o" "state=abcde" "-o"
					"ppid,pgid,sess,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etime,pcpu,pmem,args")
      (tramp-process-attributes-ps-format (pid . number)
					  (euid . number)
					  (user . string)
					  (egid . number) (comm . 52)
					  (state . 5) (ppid . number)
					  (pgrp . number)
					  (sess . number)
					  (ttname . string)
					  (tpgid . number)
					  (minflt . number)
					  (majflt . number)
					  (time . tramp-ps-time)
					  (pri . number)
					  (nice . number)
					  (vsize . number)
					  (rss . number)
					  (etime . tramp-ps-time)
					  (pcpu . number)
					  (pmem . number) (args)))
     (tramp-connection-local-busybox-ps-profile
      (tramp-process-attributes-ps-args "-o"
					"pid,user,group,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
					"-o" "stat=abcde" "-o"
					"ppid,pgid,tty,time,nice,etime,args")
      (tramp-process-attributes-ps-format (pid . number)
					  (user . string)
					  (group . string) (comm . 52)
					  (state . 5) (ppid . number)
					  (pgrp . number)
					  (ttname . string)
					  (time . tramp-ps-time)
					  (nice . number)
					  (etime . tramp-ps-time)
					  (args)))
     (tramp-connection-local-bsd-ps-profile
      (tramp-process-attributes-ps-args "-acxww" "-o"
					"pid,euid,user,egid,egroup,comm=abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
					"-o"
					"state,ppid,pgid,sid,tty,tpgid,minflt,majflt,time,pri,nice,vsz,rss,etimes,pcpu,pmem,args")
      (tramp-process-attributes-ps-format (pid . number)
					  (euid . number)
					  (user . string)
					  (egid . number)
					  (group . string) (comm . 52)
					  (state . string)
					  (ppid . number)
					  (pgrp . number)
					  (sess . number)
					  (ttname . string)
					  (tpgid . number)
					  (minflt . number)
					  (majflt . number)
					  (time . tramp-ps-time)
					  (pri . number)
					  (nice . number)
					  (vsize . number)
					  (rss . number)
					  (etime . number)
					  (pcpu . number)
					  (pmem . number) (args)))
     (tramp-connection-local-default-shell-profile
      (shell-file-name . "/bin/sh") (shell-command-switch . "-c"))
     (tramp-connection-local-default-system-profile
      (path-separator . ":") (null-device . "/dev/null"))))
 '(custom-safe-themes
   '("d445c7b530713eac282ecdeea07a8fa59692c83045bf84dd112dd738c7bcad1d"
     "a5270d86fac30303c5910be7403467662d7601b821af2ff0c4eb181153ebfc0a"
     "871b064b53235facde040f6bdfa28d03d9f4b966d8ce28fb1725313731a2bcc8"
     "ba323a013c25b355eb9a0550541573d535831c557674c8d59b9ac6aa720c21d3"
     "046a2b81d13afddae309930ef85d458c4f5d278a69448e5a5261a5c78598e012"
     "2aa073a18b2ba860d24d2cd857bcce34d7107b6967099be646d9c95f53ef3643"
     "b98ec4f494d915790c75439c02fc2f5ec4c0098e3965bd09b0aa0669225298ae"
     "bbb13492a15c3258f29c21d251da1e62f1abb8bbd492386a673dcfab474186af"
     "55c81b8ddb2b6c3fa502b1ff79fa8fed6affe362447d5e72388c7d160a2879d0"
     "f366d4bc6d14dcac2963d45df51956b2409a15b770ec2f6d730e73ce0ca5c8a7"
     "a8c595a70865dae8c97c1c396ae9db1b959e86207d02371bc5168edac06897e6"
     default))
 '(helm-completion-style 'emacs)
 '(org-agenda-files '("~/agenda.org" "~/grad-school.org"))
 '(package-selected-packages
   '(aider all-the-icons clang-format clipetty cmake-mode company counsel
	   denote-sequence exwm flycheck-clang-tidy go-mode golint
	   gotest govet gptel gruvbox-theme iedit lsp-ui paredit
	   pcap-mode pdf-tools pinentry popper projectile slime
	   tree-sitter-langs treemacs-magit use-package vterm
	   yasnippet-snippets))
 '(python-check-command "python3 -m flake8")
 '(send-mail-function 'smtpmail-send-it))


(load-local "locals-post.el")

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
