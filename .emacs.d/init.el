;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

(package-initialize)

(require 'epa-file)
(custom-set-variables '(epa-pinentry-mode 'loopback))
(custom-set-variables '(epg-gpg-program "/usr/local/bin/gpg"))
(epa-file-enable)

(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(add-to-list 'load-path site-lisp-dir)

(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

(require 'jump-char)

(global-set-key (kbd "M-m") 'jump-char-forward)
(global-set-key (kbd "M-M") 'jump-char-forward)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; No splash screen please ...jeez
(setq inhibit-startup-message t)

;; Find a way to do this earlier in startup
(add-to-list 'default-frame-alist '(undecorated . t))
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)
(setq-default indicate-empty-lines t)

;; haven't found the a perfect emulation
;; of vim's listchars yet...
;; for now, trailing spaces and all tabs
;; get underlined
;; (setq-default whitespace-style `(face trailing spaces tabs space-mark))
;; (whitespace-mode)

(setq backup-directory-alist `(("." . "~/.emacs.d/.backups")))
(setq auto-save-file-name-transforms `((".*", "~/.emacs.d/.autosaves/\\1" t)))

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "M-o") 'other-window)

;; Move more quickly
(global-set-key (kbd "C-S-n")
                (lambda ()
                  (interactive)
                  (ignore-errors (next-line 5))))

(global-set-key (kbd "C-S-p")
                (lambda ()
                  (interactive)
                  (ignore-errors (previous-line 5))))

(global-set-key (kbd "C-S-f")
                (lambda ()
                  (interactive)
                  (ignore-errors (forward-char 5))))

(global-set-key (kbd "C-S-b")
                (lambda ()
                  (interactive)
                  (ignore-errors (backward-char 5))))

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require 'package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-browser-function (quote eww-browse-url))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/"))))
 '(package-selected-packages (quote (exec-path-from-shell magit haskell-mode))))
(package-initialize)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-space ((t (:distant-foreground "black" :foreground "#FFFFFF"))))
 '(whitespace-tab ((t (:underline t))))
 '(whitespace-trailing ((t (:underline t)))))
