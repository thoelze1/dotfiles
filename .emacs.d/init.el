;; Tell emacs where other config files are
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory)
      settings-dir
      (expand-file-name "settings" user-emacs-directory))
(add-to-list 'load-path site-lisp-dir)
(add-to-list 'load-path settings-dir)

;; Add remote packages to load path
;; You don't have to require packages 
(package-initialize)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   (quote
    ("~/git/org/activites.org" "~/git/thoelze1.github.io/org/sicp-exercises.org" "~/git/org/vocab.org" "~/git/org/reading.org" "~/git/org/quotes.org" "~/git/org/projects.org" "~/git/org/music.org" "~/git/org/misc.org" "~/git/org/log.org" "~/git/org/journal.org" "~/git/org/blog.org" "~/git/org/8bit.org")))
 '(package-selected-packages
   (quote
    (exwm htmlize org-babel-eval-in-repl paredit zenburn-theme avy slime sicp multiple-cursors exec-path-from-shell magit haskell-mode))))

;; Add local projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))
(require 'spotify)
(require 'vimgolf)

;; Keep all backups together and all autosaves together
(setq backup-directory-alist `(("." . "~/.emacs.d/.backups"))
      auto-save-file-name-transforms `((".*", "~/.emacs.d/.autosaves/\\1" t)))

(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)
(setq-default indicate-empty-lines t)

;; Reread these and fix zsh/shell stuff
;; https://github.com/purcell/exec-path-from-shell
;; https://blog.flowblok.id.au/2013-02/shell-startup-scripts.html
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require 'org-settings)
(require 'secrets)
(require 'spotify-settings)
(require 'appearance)
(require 'key-bindings)
(require 'avy-settings)
(if (string-equal system-type "gnu/linux")
    (require 'exwm-settings)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(org-babel-do-load-languages
 'org-babel-load-languages '((scheme . t)))

(add-hook 'scheme-mode-hook #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)

(defun copy-sexp ()
  (interactive)
  (save-window-excursion
    (save-excursion
      (avy-goto-char ?\()
      (mark-sexp)
      (kill-ring-save (point) (mark))
      (pop-mark)
      (pop-mark))))

(global-set-key (kbd "C-c C-M-@") 'copy-sexp)

;; (setq geiser-active-implementations '(mit))
(setq ring-bell-function 'ignore)
