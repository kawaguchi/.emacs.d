(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-hook 'php-mode-hook
  '(lambda ()
     (define-key php-mode-map (kbd "C-.") nil)))
