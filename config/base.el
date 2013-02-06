(menu-bar-mode -1)
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
