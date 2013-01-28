(setq auto-async-byte-compile-exclude-files-regexp (expand-file-name dress-config-path))
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)
