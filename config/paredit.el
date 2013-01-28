;; Cheatsheet
;; http://mumble.net/~campbell/emacs/paredit/paredit.html
(mapc (lambda (mode)
        (let ((hook (intern (concat (symbol-name mode)
                                    "-mode-hook"))))
          (add-hook hook (lambda ()
                           (paredit-mode 1)))))
      '(emacs-lisp common-lisp scheme clojure lisp inferior-lisp lisp-interaction ielm))
