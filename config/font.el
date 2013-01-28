(when window-system
  (let ((font "Monaco-14"))
    (setq fixed-width-use-QuickDraw-for-ascii t)
    (setq mac-allow-anti-aliasing t)
    (set-default-font font)
    (add-to-list 'default-frame-alist `(font . ,font))
    (set-fontset-font (frame-parameter nil 'font)
		      'japanese-jisx0208
		      '("Hiragino Maru Gothic Pro" . "iso10646-1"))
    (setq face-font-rescale-alist
	  '(("^-apple-hiragino.*" . 1.0)
	    (".*osaka-bold.*" . 1.0)
	    (".*osaka-medium.*" . 1.0)
	    (".*courier-bold-.*-mac-roman" . 1.0)
	    (".*monaco cy-bold-.*-mac-cyrillic" . 0.9)
	    (".*monaco-bold-.*-mac-roman" . 0.9)
	    ("-cdac$" . 1.3)))))
