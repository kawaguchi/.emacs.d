(add-hook 'org-mode-hook
          '(lambda ()
             (local-unset-key (kbd "C-,"))))

(defun open-org-default-notes-file ()
  (interactive)
  (find-file org-default-notes-file))
(global-set-key (kbd "<f5>") 'open-org-default-notes-file)

(setq org-agenda-files (list org-default-notes-file))
(define-key global-map (kbd "C-c a") 'org-agenda)

;; http://orgmode.org/manual/Template-expansion.html#Template-expansion
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline org-default-notes-file "Inbox")
         "* TODO %?\n  %i\n\n  %U\n  %a")
        ("n" "Note" entry (file+headline org-default-notes-file "Inbox")
         "* %?\n\n  %U\n  %i")))
(define-key global-map (kbd "C-c c") 'org-capture)

;; http://orgmode.org/worg/org-contrib/babel/languages/ob-doc-ledger.html
(add-to-list 'org-babel-load-languages '(ledger . t))
