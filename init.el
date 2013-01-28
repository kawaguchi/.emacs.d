(add-to-list 'load-path user-emacs-directory)

(require 'dresser)
(dress-up)

;; load other config files
(let* ((re "\\.elc?$")
       (config-files (delete-dups
                      (mapcar (lambda (file)
                                (replace-regexp-in-string re "" file))
                              (directory-files dress-config-path nil re)))))
  (dolist (dress-config (dress-config-list))
    (delete dress-config config-files))
  (mapc 'dress-load-config config-files))
