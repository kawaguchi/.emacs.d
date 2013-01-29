(setq org-agenda-files (list (concat (file-name-as-directory org-directory) "gtd.org")))
(define-key global-map (kbd "C-c a") 'org-agenda)

;; http://orgmode.org/manual/Template-expansion.html#Template-expansion
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "gtd.org" "Inbox")
         "* TODO %?\n  %i\n\n  %U\n  %a")
        ("n" "Note" entry (file+headline "gtd.org" "Inbox")
         "* %?\n\n  %U\n  %i")
        ("j" "Journal" entry (file+datetree "journal.org")
         "* %?\n  %i\n\n  %U\n  %a")))
(define-key global-map (kbd "C-c c") 'org-capture)
