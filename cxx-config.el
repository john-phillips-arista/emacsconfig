(defvar sensible-c-style '("K&R"
			 (c-basic-offset . 2)
			 (c-offsets-alist
			    .
			    ((inline-open . 0)))))
(c-add-style "Sensible" sensible-c-style)

(defun c-arglist-indentation ()
  "Set normal indentation for arglists.
Otherwise we will be on the same column as the paren."
  (c-set-offset 'arglist-intro '++))
(use-package clang-format :ensure t)

(defun my-cxx-format ()
  (interactive)
  (let* ((projectile-root (projectile-project-root))
	 (filename (f-join projectile-root ".clang-format"))
	 (exists-p (f-exists-p filename))
	 (contents (and exists-p (f-read-text filename))))
    (when (and exists-p (not (string= contents "")))
      (clang-format-buffer))))

(add-to-list 'auto-mode-alist '("\\.cppm\\'" . c++-mode))




(defun enable-cxx-checkers ()
  (interactive)
  (flycheck-add-next-checker 'lsp 'c/c++-clang-tidy)
  (flycheck-add-next-checker 'c/c++-clang-tidy 'c/c++-cppcheck))

(use-package cc-mode
  :ensure t
  :config
  (progn
    (cl-loop for hook in '(display-line-numbers-mode column-number-mode lsp company-mode) do
	     (add-hook 'c++-mode-hook hook))
    (add-hook 'c++-mode-hook 'enable-cxx-checkers 99 t)
    (add-hook 'c++-mode-hook
	      (lambda () (add-hook 'before-save-hook 'my-cxx-format nil 'local)))))

(use-package flycheck-clang-tidy
  :ensure t
  :after flycheck
  :hook
  (flycheck-mode . flycheck-clang-tidy-setup))

(defun c++-toggle-header-cpp-file ()
  (interactive)
  (let* ((current-bufname (buffer-name (current-buffer)))
	 (c-file-match (string-match "\\.c\\(pp\\|xx\\|c\\)?$" current-bufname))
	 (c-file-suffix (match-string 1 current-bufname))
	 (h-file-match (string-match "\\.h\\(pp\\|xx\\|h\\)?$" current-bufname))
	 (h-file-suffix (match-string 1 current-bufname)))
    (cond
     (c-file-match
      (let ((new-buffer-base (substring current-bufname
					0 c-file-match)))
	(switch-to-buffer
	 (concat
	  new-buffer-base
	  ".h"
	  (or c-file-suffix "")))))
     (h-file-match
      (let ((new-buffer-base (substring current-bufname
					0 h-file-match)))
	(switch-to-buffer
	 (concat
	  new-buffer-base
	  ".c"
	  (or h-file-suffix ""))))))))
(use-package cmake-mode :ensure t)

(require 'projectile)

(defcustom *standard-build-dir* "conan-install"
  "Standard directory within a C++ project to do builds.")

(setf lsp-clangd-version "19.1.0")
(setq lsp-clients-clangd-executable "/usr/bin/clangd-19")
(setf lsp-clangd-binary-path "/usr/bin/clangd-19")
(use-package man
  :config
  (setf Man-notify-method 'pushy))

(defun cxx-compile-and-test (test-regex)
  "Compile and test using test-regex."
  (interactive "sregex: ")
  (let ((default-directory (projectile-project-root)))
    (compile (format "cmake --build %s && cd %s && ctest -VV -R %s"
		   *standard-build-dir*
		   *standard-build-dir*
		   test-regex))))
