(setq whitespace-style
      '(tabs spaces space-mark))
(setq whitespace-space-regexp "\\( +\\|\u3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])))
(global-whitespace-mode 1)
(setq-default tab-width 4
              indent-tabs-mode nil)
