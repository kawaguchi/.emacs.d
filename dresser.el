;;; dresser.el --- Emacs plugin manager

;; Author: Masaya Kawaguchi <masayakawaguchi@gmail.com>
;; URL: https://github.com/kawaguchi/Emacs-Dressing-Room
;; Version: 0.0.1
;; Created: 21 Sep 2012

;; This file is NOT part of GNU Emacs.

;;; License
;;
;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the

;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:

(require 'package)

(defvar dress-closet-path (concat user-emacs-directory "closet"))
(defvar dress-config-path (concat user-emacs-directory "config"))
(defvar dress-code-file (concat user-emacs-directory "Dresscode"))

(defun dress-parse-code ()
  (with-temp-buffer
    (insert-file-contents dress-code-file)
    (delq nil
          (mapcar (lambda (line)
                    (setq line (replace-regexp-in-string "\s*;.*" "" line))
                    (mapcar (lambda (key)
                              (if (string-match "^:." key)
                                  (intern key)
                                key))
                            (split-string line "\s+" t)))
                  (split-string (buffer-string) "\n" t)))))

(defun dress-merge-alist (alist other)
  (setq alist (copy-alist alist))
  (dolist (pair other)
    (let* ((key (car pair))
           (value (cdr pair))
           (found (assq key alist)))
      (if found
          (setcdr found value)
        (add-to-list 'alist pair))))
  alist)

(defun dress-resolve-option (option)
  (let ((key (car option))
        (value (cadr option))
        (rest (cddr option))
        result)
    (when option
      (unless (keywordp key)
        (error "Invalid dress option %s" option))
      (cond ((keywordp value)
             (setq value t
                   rest (cdr option)))
            ((null value)
             (setq value (if rest nil t))))
      (setq result (cons key value))
      (cons result (dress-resolve-option rest)))))

(defun dress-create (option)
  (setq option (dress-merge-alist '((:require . t)) ;; default option
                                  option))
  (let* ((hash (make-hash-table))
         (feature (assoc-default :feature option))
         (name (symbol-name feature))
         (elpa (assoc-default :elpa option))
         (git (assoc-default :git option))
         (github (assoc-default :github option))
         (emacswiki (assoc-default :emacswiki option))
         (url (assoc-default :url option))
         (require-feature (assoc-default :require option))
         (config (assoc-default :config option)))
    (puthash :feature feature hash)
    (puthash :name name hash)
    (cond (elpa (puthash :source :elpa hash)
        (puthash :url nil hash)
        (puthash :closet (format "%s/elpa/%s" dress-closet-path feature) hash))
          (git (puthash :source :git hash)
           (setq git (format "%s" git))
           (puthash :url git hash)
           (puthash :closet (format "%s/git/%s" dress-closet-path feature) hash))
          (github (puthash :source :github hash)
          (setq github (format "%s" github))
          (puthash :url (format "https://github.com/%s.git" github) hash)
          (puthash :closet (format "%s/github/%s" dress-closet-path feature) hash))
          (emacswiki (puthash :source :emacswiki hash)
                     (puthash :url (format "http://www.emacswiki.org/emacs/download/%s.el" feature) hash)
                     (puthash :closet (format "%s/emacswiki/%s" dress-closet-path feature) hash))
          (url (puthash :source :url hash)
           (setq url (format "%s" url))
           (puthash :url url hash)
           (puthash :closet (format "%s/url/%s" dress-closet-path feature) hash))
          (t (puthash :source :builtin hash)
         (puthash :url nil hash)
         (puthash :closet nil hash)))
    (puthash :require (cond ((eq require-feature t)
                             feature)
                            ((null require-feature)
                             nil)
                            (t (intern require-feature))) hash)
    (puthash :config (or config name) hash)
  hash))

(defun dress-list ()
   (mapcar
    (lambda (dress-code)
      (let ((feature (intern (car dress-code)))
            (option (cdr dress-code)))
        (dress-create (cons (cons :feature feature)
                            (dress-resolve-option option)))))
    (dress-parse-code)))

(defun dress-find (name-or-feature)
  (let ((name (if (symbolp name-or-feature)
                  (symbol-name name-or-feature)
                name-or-feature)))
    (catch 'result
      (dolist (dress (dress-list))
        (when (equal name (gethash :name dress))
          (throw 'result dress))))))

(defun dress-update (dress)
  (interactive)
  (let ((feature (gethash :feature dress))
        (source (gethash :source dress))
        (url (gethash :url dress))
        (closet (gethash :closet dress)))
    (cond ((eq source :elpa)
           ;; TODO
           nil)
          ((or (eq source :git)
               (eq source :github))
           (dress-git-pull feature closet))
          ((or (eq source :emacswiki)
               (eq source :url))
           (dress-wget feature url closet)))))

(defun dress-config-list ()
  (delq nil (mapcar (lambda (dress) (gethash :config dress)) (dress-list))))

(defun dress-installed-p (dress &optional loadpath)
  (setq loadpath (or loadpath load-path))
  (let ((name (symbol-name (gethash :require dress)))
        (path (car loadpath))
        (rest (cdr loadpath)))
    (if (or (file-exists-p (format "%s/%s.elc" path name))
            (file-exists-p (format "%s/%s.el" path name)))
        t
      (if rest
          (dress-installed-p dress (cdr loadpath))))))

(defun dress-find-all-not-installed ()
  (let (dresses)
    (dolist (dress (dress-list))
      (unless (dress-installed-p dress)
        (add-to-list 'dresses dress)))
    dresses))

(defun dress-install (&optional dress)
  (interactive)
  (if (null dress)
      (progn
        (mapc 'dress-install (dress-find-all-not-installed))
        (message "Dress install completed")
        t)
    (let ((feature (gethash :feature dress))
          (source (gethash :source dress))
          (url (gethash :url dress))
          (closet (gethash :closet dress)))
      (cond ((eq source :elpa)
             (dress-package-install feature closet))
            ((or (eq source :git)
                 (eq source :github))
             (dress-git-clone feature url closet))
            ((or (eq source :emacswiki)
                 (eq source :url))
             (dress-wget feature url closet))))))

(defun dress-package-install (name closet)
  (if (file-exists-p closet)
      (message "Installed %s" name)
    (message "Installing %s to %s" name closet)
    (let ((package-user-dir (format "%s/elpa/" dress-closet-path)))
      (package-install name))))

(defun dress-git-clone (feature url closet)
  (if (file-exists-p closet)
      (message "Installed %s" feature)
    (message "Installing %s to %s" feature closet)
    (make-directory closet t)
    (shell-command-to-string (format "git clone %s %s" url closet))
    (when (file-exists-p (format "%s/.gitmodules" closet))
      (message "Updating %s's submodules" feature)
      (cd closet)
      (shell-command-to-string "git submodule update --init --recursive"))))

(defun dress-git-pull (feature closet)
  (if (file-exists-p closet)
      (progn
        (cd closet)
        (shell-command-to-string "git pull")
        (when (file-exists-p (format "%s/.gitmodules" closet))
          (message "Updating %s's submodules" feature)
          (shell-command-to-string "git submodule update --init --recursive")))
    (message "%s is not installed" feature)))

(defun dress-wget (feature url closet)
  (if (file-exists-p closet)
      (message "Installed %s" feature)
    (message "Installing %s to %s" feature closet)
    (make-directory closet t)
    (shell-command-to-string (format "wget %s -P %s" url closet))))

(defun dress-check ()
  (if (dress-missing-features) nil t))

(defun dress-missing-features ()
  (mapconcat (lambda (dress)
               (gethash :name dress))
             (dress-find-all-not-installed)
             "\n"))

(defvar dress-loaded-config-list nil)
(defvar dress-load-errors nil)

(defun dress-require (feature)
  (condition-case err
      (require feature)
    (error (if (boundp 'dress-load-errors)
               (add-to-list 'dress-load-errors
                            (format "Error occurred when loading %s: %s" feature err))))))

(defun dress-load-config (config)
  (condition-case err
      (when (load (format "%s/%s" dress-config-path config) 'NOERROR)
        (add-to-list 'dress-loaded-config-list config))
    (error (if (boundp 'dress-load-errors)
               (add-to-list 'dress-load-errors
                            (format "Error occurred when loading %s config: %s" config err))))))

(defun dress-up ()
  (interactive)
  (setq dress-loaded-config-list nil)
  (package-initialize)
  (let (dress-load-errors)
    (dolist (dress (dress-list))
      (let ((require (gethash :require dress))
            (closet (gethash :closet dress))
            (config (gethash :config dress)))
        (if (featurep require)
          (progn
            (message "Provided %s" require)
            (dress-load-config config)))
        (if closet (add-to-list 'load-path closet))
        (when (dress-require require)
          (message "Loaded %s" require)
          (dress-load-config config))))
    (if dress-load-errors
        (mapc 'message dress-load-errors)
      (message "Dress up completed"))))

(provide 'dresser)
;;; dresser.el ends here.
