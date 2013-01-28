(add-to-list 'auto-mode-alist '("Dresscode" . emacs-lisp-mode))

(defun insert-kbd ()
  (interactive)
  (insert (format "(kbd \"%s\")"
                  (key-description (read-key-sequence "")))))
(define-key emacs-lisp-mode-map (kbd "C-c k") 'insert-kbd)
