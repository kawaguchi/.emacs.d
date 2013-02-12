(global-rinari-mode)

(defun rinari-cheat-sheet ()
  (interactive)
  (message "Rinari Cheat sheet
 C-c ; f c  rinari-find-controller		C-c ; f e  rinari-find-environment
 C-c ; f f  rinari-find-file-in-project	C-c ; f h  rinari-find-helper
 C-c ; f i  rinari-find-migration		C-c ; f j  rinari-find-javascript
 C-c ; f l  rinari-find-plugin			C-c ; f m  rinari-find-model
 C-c ; f n  rinari-find-configuration	C-c ; f o  rinari-find-log
 C-c ; f p  rinari-find-public			C-c ; f s  rinari-find-script
 C-c ; f t  rinari-find-test			C-c ; f v  rinari-find-view
 C-c ; f w  rinari-find-worker			C-c ; f x  rinari-find-fixture
 C-c ; f y  rinari-find-stylesheet		C-c ; f g  rinari-find-gemfile
 C-c ; f M  rinari-find-mailers"))

(defun rinari-find-gemfile ()
  (interactive)
  (find-file (concat (rinari-root) "Gemfile")))
(define-key rinari-minor-mode-map (kbd "C-c ; f g") 'rinari-find-gemfile)

(defun bundle-install ()
  (interactive)
  (if (and (string-match "/Gemfile$" (buffer-file-name))
           (y-or-n-p "bundle install?"))
      (async-shell-command "bundle install")))
(add-hook 'after-save-hook 'bundle-install)
