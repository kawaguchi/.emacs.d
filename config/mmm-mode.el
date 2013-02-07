(setq mmm-submode-decoration-level 1
      mmm-parse-when-idle t
      mmm-global-mode 'auto)

(require 'mmm-erb)
(mmm-add-mode-ext-class 'html-erb-mode "\\.html\\.erb\\'" 'erb)
(mmm-add-mode-ext-class 'html-erb-mode nil 'html-js)
(mmm-add-mode-ext-class 'html-erb-mode nil 'html-css)
(add-to-list 'auto-mode-alist '("\\.html\\.erb\\'" . html-erb-mode))

(define-derived-mode conf-erb-mode conf-mode "ERB-CONF"
  (add-hook 'mmm-conf-erb-mode-hook 'mmm-erb-process-submode nil t)
  (add-hook 'mmm-ruby-mode-submode-hook 'mmm-erb-process-submode nil t))
(mmm-add-mode-ext-class 'conf-erb-mode "\\.conf\\.erb\\'" 'erb)
(add-to-list 'auto-mode-alist '("\\.conf\\.erb\\'" . conf-erb-mode))
