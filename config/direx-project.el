(setq direx:leaf-icon "  "
      direx:open-icon "▾ "
      direx:closed-icon "▸ ")
(push '(direx:direx-mode :position left :width 35 :dedicated t)
      popwin:special-display-config)

(defun direx-project:jump-to-project-root-or-directory-other-window ()
  (interactive)
  (or (ignore-errors (direx-project:jump-to-project-root-other-window))
      (direx:jump-to-directory-other-window)))
(global-set-key (kbd "C-x C-j") 'direx-project:jump-to-project-root-or-directory-other-window)
