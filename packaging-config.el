(require 'package)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(setf package-user-dir "~/.cache/elpa")
(setf package-gnupghome-dir "~/.cache/elpa/gnupg")
(package-initialize)
(package-refresh-contents)
(package-install 'use-package)
(require 'use-package)
