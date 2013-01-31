(global-set-key (kbd "C-;") 'helm-mini)
(global-set-key (kbd "M-x") 'helm-M-x)
(eval-after-load "helm"
  '(if (boundp 'helm-map) (define-key helm-map (kbd "C-h") 'delete-backward-char)))
