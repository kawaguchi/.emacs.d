(setq skk-preload t
      skk-jisyo-code 'utf-8
      default-input-method "japanese-skk"
      skk-henkan-strict-okuri-precedence t
      skk-check-okurigana-on-touroku t
      skk-kakutei-key (kbd "C-\'")
      skk-egg-like-newline t
      skk-server-host "127.0.0.1"
      skk-server-portnum 1178
      skk-jisyo (concat (getenv "HOME") "/Dropbox/skk/skk-jisyo.utf8"))

(mapc (lambda (command)
        (let ((hook (intern (concat (symbol-name command)
                                    "-hook"))))
          (add-hook hook (lambda () (skk-mode t) (skk-latin-mode t)))))
      '(find-file minibuffer-setup lisp-interaction-mode magit-log-edit-mode))
