(setq wgrep-auto-save-buffer t
      wgrep-enable-key "r")

(autoload 'wgrep-ag-setup "wgrep-ag")
(add-hook 'ag-mode-hook 'wgrep-ag-setup)
