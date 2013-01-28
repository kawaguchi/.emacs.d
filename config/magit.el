;; magit cheatsheet
;; TAB(C-i) diff
;; s        stage
;; S        all stage
;; u        unstage
;; U        all unstage
;; k        discard changes
;; c        commit
;; C-c C-c  commit all changes
;; P        push
;; l        log
;; C-c a    amend

(setq vc-handled-backends nil)
(global-set-key (kbd "C-x g") 'magit-status)
