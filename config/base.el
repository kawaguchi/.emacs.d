(dolist (dir (mapcar 'expand-file-name '("~/bin" "/usr/local/bin")))
   (setenv "PATH" (concat dir path-separator (getenv "PATH")))
   (setq exec-path (append (list dir) exec-path)))

(setq initial-frame-alist
      '((width . 120) (height . 40)
        (alpha 90 66)))
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-scroll-bar-mode nil)
(setq ns-command-modifier   'meta
      ns-alternate-modifier 'super)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-message t)
(column-number-mode t)
(blink-cursor-mode t)
(auto-save-mode -1)

(setq make-backup-files nil
      auto-save-default nil
      backup-enable-predicate nil
      backup-inhibited nil
      auto-save-list-file-prefix "~/Tmp/"
      next-line-add-newlines nil
      kill-whole-line t
      auto-coding-functions nil)

(setq-default transient-mark-mode t)
(delete-selection-mode t)
(show-paren-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(defalias 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "C-x k") (lambda() (interactive) (kill-buffer (buffer-name))))

(load-theme 'deeper-blue)
