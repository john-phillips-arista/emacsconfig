(require 'comp)
(setf exec-path
      (append
       (list "/home/john/.guix-profile/bin")
       exec-path))

(require 'clang-format)
(setf clang-format-executable
      "/home/john/.guix-profile/bin/clang-format")

(setf native-comp-driver-options
      (list
       "-B" "/home/john/.guix-profile/lib"
       "-B" "/home/john/.guix-profile/bin"
       "-B" "/home/john/.guix-home/profile/lib"
       "-B" "/home/john/.guix-home/profile/lib/gcc"
       "-B" "/home/john/.guix-home/profile/lib/gcc/x86_64-unknown-linux-gnu/12.3.0/"       
       "-B" "/home/john/.guix-home/profile/bin"))

(require 'recentf)
(setf recentf-save-file "~/.cache/emacs/recentf")
(require 'transient)
(setf transient-history-file "~/.cache/transient/history.el")
