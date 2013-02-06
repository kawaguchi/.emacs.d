(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "<right>") 'next-buffer)
(global-set-key (kbd "<left>") 'previous-buffer)
(global-set-key (kbd "C-x l") 'goto-line)

(global-set-key (kbd "M--") 'split-window-vertically)
(global-set-key (kbd "M-|") 'split-window-horizontally)
(global-set-key (kbd "C-o") 'other-window)
(global-set-key (kbd "<s-tab>") 'other-frame)
(global-set-key (kbd "M-[") 'shrink-window-horizontally)
(global-set-key (kbd "M-]") 'enlarge-window-horizontally)

(global-set-key (kbd "C-v") (lambda () (interactive) (scroll-up-command 2)))
(global-set-key (kbd "M-v") (lambda () (interactive) (scroll-down-command 2)))

(define-key read-expression-map (kbd "TAB") 'lisp-complete-symbol)

(global-unset-key (kbd "C-x u"))   ; undo
(global-unset-key (kbd "C-x C-u")) ; upcase-region
(global-unset-key (kbd "C-\\"))    ; toggle-input-method
(global-unset-key (kbd "C-x t"))   ; skk-tutorial
(global-unset-key (kbd "M-<"))     ; beggining-of-buffer use C-a C-a
(global-unset-key (kbd "M->"))     ; end-of-buffer use C-e C-e
(global-unset-key (kbd "<f3>"))    ; kmacro-start-macro-or-insert-counter
(global-unset-key (kbd "<f10>"))   ; menu-bar-open

(find-function-setup-keys)

(defun open-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))
(global-set-key (kbd "<f2>") 'open-scratch)

(defun open-messages ()
  (interactive)
  (switch-to-buffer "*Messages*"))
(global-set-key (kbd "<f3>") 'open-messages)

(defun describe-face-at-point ()
 (interactive)
 (message "%s" (get-char-property (point) 'face)))
(global-set-key (kbd "C-c C-f") 'describe-face-at-point)
