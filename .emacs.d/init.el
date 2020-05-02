;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen please ...jeez
(setq inhibit-startup-message t)

;; Tell emacs where other config files are
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory)
      settings-dir
      (expand-file-name "settings" user-emacs-directory))
(add-to-list 'load-path site-lisp-dir)
(add-to-list 'load-path settings-dir)

;; Load appearance settings
(require 'appearance)

(package-initialize)

(require 'package)

(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (zenburn-theme avy slime sicp multiple-cursors exec-path-from-shell magit haskell-mode))))

(put 'downcase-region 'disabled nil)

(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))

(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)
(setq-default indicate-empty-lines t)

(setq backup-directory-alist `(("." . "~/.emacs.d/.backups"))
      auto-save-file-name-transforms `((".*", "~/.emacs.d/.autosaves/\\1" t)))

(defun cpp-panes (dirname)
  (interactive "D")
  (new-frame)
  (delete-other-windows)
  (dired dirname)
  (split-window-right)
  (magit-status dirname)
  (split-window-below)
  (shell)
  (windmove-left))

(require 'org)

(require 'secrets)

;; avy stuff
;; https://github.com/abo-abo/avy/wiki/defcustom
(setq avy-keys '(?f ?j ?d ?k ?s ?l ?a ?\; ?' ?v ?n ?c ?m ?x ?, ?z
                 ?. ?b ?/ ?t ?u ?r ?i ?e ?o ?w ?p ?q ?\[ ?5 ?7 ?4
                 ?8 ?3 ?9 ?2 ?0 ?1 ?- ?6 ?= ?\] ?\\ ?` ?F ?J ?D ?K
                 ?S ?L ?A ?: ?\" ?V ?N ?C ?M ?X ?< ?Z ?> ?B ?? ?T
                 ?U ?R ?I ?E ?O ?W ?P ?Q ?{ ?% ?& ?$ ?* ?# ?\( ?@
                 ?\) ?! ?_ ?^ ?+ ?} ?| ?~))
(setq avy-case-fold-search nil)

;; spotify stuff
(require 'spotify)
(define-key spotify-mode-map (kbd "C-c .") 'spotify-command-map)

;; Reread these and fix zsh/shell stuff
;; https://github.com/purcell/exec-path-from-shell
;; https://blog.flowblok.id.au/2013-02/shell-startup-scripts.html
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require 'key-bindings)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
