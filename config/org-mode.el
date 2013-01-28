(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/.org/todo.org" "Tasks")
         "* TODO %?n %in %a")
        ("j" "Journal" entry (file+datetree "~/.org/journal.org")
         "* %?n %Un %in %a")
        ("n" "Note" entry (file+headline "~/.org/notes.org" "Notes")
         "* %?n %Un %i")
        ))
(define-key global-map (kbd "C-c c") 'org-capture)
