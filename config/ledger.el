(defun open-ledger ()
  (interactive)
  (find-file my-ledger-file))
(global-set-key (kbd "<f4>") 'open-ledger)
