(defun increase-opacity ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter nil 'alpha
                         (cond ((or (null alpha) (>= alpha 100)) 100)
                               ((listp alpha) (car alpha))
                               (t (+ alpha 5))))))

(defun decrease-opacity ()
  (interactive)
  (let ((alpha (frame-parameter nil 'alpha)))
    (set-frame-parameter nil 'alpha
                         (cond ((null alpha) 100)
                               ((listp alpha) (car alpha))
                               ((<= alpha frame-alpha-lower-limit) frame-alpha-lower-limit)
                               (t (- alpha 5))))))

(global-set-key (kbd "M-<f2>") 'increase-opacity)
(global-set-key (kbd "M-<f1>") 'decrease-opacity)
