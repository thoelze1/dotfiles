; Local packages
;; Tell emacs where other config files are
(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))
(add-to-list 'load-path site-lisp-dir)
;; Add local projects to load path
(dolist (project (directory-files site-lisp-dir t "\\w+"))
  (when (file-directory-p project)
    (add-to-list 'load-path project)))
(require 'spotify)
(require 'vimgolf)

; Remote packages
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
 '(custom-safe-themes
   (quote
    ("76c5b2592c62f6b48923c00f97f74bcb7ddb741618283bdb2be35f3c0e1030e3" default)))
 '(package-selected-packages
   (quote
    (fancy-battery xelb haskell-mode geiser ox-twbs yasnippet exwm htmlize org-babel-eval-in-repl paredit zenburn-theme avy slime sicp multiple-cursors exec-path-from-shell magit))))

; Security (? I forget)
(if (string-equal system-type "gnu/linux")
    (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

; Backups, autosaves, desktop
;; Keep all backups together and all autosaves together
(setq backup-directory-alist `(("." . "~/.emacs.d/.backups"))
      auto-save-file-name-transforms `((".*", "~/.emacs.d/.autosaves/\\1" t)))
(setq desktop-path '("~/.emacs.d/desktop"))

; Shell
;; Reread these and fix zsh/shell stuff
;; https://github.com/purcell/exec-path-from-shell
;; https://blog.flowblok.id.au/2013-02/shell-startup-scripts.html
(if (string-equal system-type "darwin")
    (when (memq window-system '(mac ns x))
      (exec-path-from-shell-initialize)));

; Dired
(add-hook 'dired-mode-hook 'auto-revert-mode)

; Paredit
(add-hook 'scheme-mode-hook #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)

; Tabs vs spaces
(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)
(setq-default indicate-empty-lines t)

; Disabled functions
(put 'upcase-region 'disabled nil)

; Geiser
(setq geiser-active-implementations '(mit))
(setq geiser-default-implementation 'mit)

; Yasnippet
(require 'yasnippet) ;; this shouldn't be necessary? because of package-initialize?
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(add-hook 'scheme-mode-hook #'yas-minor-mode)
(yas-reload-all)

; Ido
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq initial-buffer-choice "~/git")

; Appearance
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(if (string-equal system-type "darwin")
    (progn
      (add-to-list 'default-frame-alist '(font . "SF Mono-12"))
      (add-to-list 'default-frame-alist '(undecorated . t))
      (add-to-list 'default-frame-alist '(fullscreen . maximized))))
;; set transparency
;; https://lwn.net/Articles/88179/
;; first value is for active frame, second value is for inactive frame
;; (set-frame-parameter (selected-frame) 'alpha '(99 100))
(setq ring-bell-function 'ignore)

; Avy
;; https://github.com/abo-abo/avy/wiki/defcustom
(setq avy-keys '(?f ?j ?d ?k ?s ?l ?a ?\; ?' ?v ?n ?c ?m ?x ?, ?z
                 ?. ?b ?/ ?t ?u ?r ?i ?e ?o ?w ?p ?q ?\[ ?5 ?7 ?4
                 ?8 ?3 ?9 ?2 ?0 ?1 ?- ?6 ?= ?\] ?\\ ?` ?F ?J ?D ?K
                 ?S ?L ?A ?: ?\" ?V ?N ?C ?M ?X ?< ?Z ?> ?B ?? ?T
                 ?U ?R ?I ?E ?O ?W ?P ?Q ?{ ?% ?& ?$ ?* ?# ?\( ?@
                 ?\) ?! ?_ ?^ ?+ ?} ?| ?~))
(setq avy-case-fold-search nil)
(global-set-key (kbd "H-a") 'avy-goto-char)

; Exwm
(if (string-equal system-type "gnu/linux")
    (progn
      (require 'exwm)
      (require 'exwm-config)
      (exwm-config-default)
      (setq fancy-battery-show-percentage t)
      (fancy-battery-mode)
      (exwm-input-set-key (kbd "<XF86MonBrightnessDown>")
		    (lambda ()
		      (interactive)
		      (shell-command "light -U 5; light")))
      (exwm-input-set-key (kbd "<XF86MonBrightnessUp>")
		    (lambda ()
		      (interactive)
		      (shell-command "light -A 5; light")))))

; Keybindings
;; This is the global behavior in OSX so we'll keep that for emacs
(global-set-key (kbd "s-<backspace>") (lambda ()
                                        (interactive)
                                        (if (= (current-column) 0)
                                            (backward-delete-char 1)
                                          (kill-line 0))))
;; I have karabiner map space to fn globally. I then have emacs map fn
;; to hyper. However, OSX translates some keychords containing fn into
;; keychords without the fn key. I know of two such cases: fn+f3
;; translates to f3 (as do the other numbered fn keys) and fn+<left>
;; translates to <home> (the other arrows keys have similar
;; translations). Therefore, some of the keybindings below use the the
;; translation from OSX instead of a chord with H (<home> instead of
;; <H-left>, for example)
(if (string-equal system-type "darwin")
    (setq ns-function-modifier 'hyper))
(if (string-equal system-type "gnu/linux")
    (setq ns-right-control-modifier 'hyper))
;; Note how many bindings we can have for number keys! First, we have
;; 10 number keys and 10 numbered function keys. We then have 5
;; modifiers (control, shit, meta, super, hyper) which can be chorded,
;; and then for the function-number keys (f1, f2 etc) we have 4
;; modifiers! Supposing we can reasonably use 3 modifiers with a
;; keypress, that's 1 + 5 + 10 + 10 = 26 ways of pressing a number
;; key, and 1 + 5 + 10 = 15 ways of pressing a numbered function key
;; for a total of 26 + 15 = 41 ways of pressing a generic "number"
;; key. Insane!
(global-set-key (kbd "s-0") 'delete-window)
(global-set-key (kbd "s-1") 'delete-other-windows)
(global-set-key (kbd "s-2") 'split-window-below)
(global-set-key (kbd "s-3") 'split-window-right)
(global-set-key (kbd "H-g") 'magit-status)
(global-set-key (kbd "<S-f3>") 'kmacro-end-macro)
(global-set-key (kbd "H-c") 'mc/edit-lines)
(global-set-key (kbd "s-f") 'make-frame)
(global-set-key (kbd "s-n") 'other-window)
(defun prev-window ()
  (interactive)
  (other-window -1))
(global-set-key (kbd "s-p") 'prev-window)
(global-set-key (kbd "s-o") 'find-file)
(global-set-key (kbd "s-[") 'previous-buffer)
(global-set-key (kbd "s-]") 'next-buffer)
(defun next-window-next-buffer ()
  (interactive)
  (other-window 1)
  (next-buffer)
  (prev-window))
(defun next-window-prev-buffer ()
  (interactive)
  (other-window 1)
  (previous-buffer)
  (prev-window))
;; I don't like these bindings because my keyboard rollover doesn't
;; support using left hand shift (f key) with ] (so I have to use my
;; right hand for ])
(global-set-key (kbd "s-{") 'next-window-prev-buffer)
(global-set-key (kbd "s-}") 'next-window-next-buffer)
;; This works...
(global-set-key (kbd "<C-s-268632091>") 'next-window-prev-buffer)
(global-set-key (kbd "<C-s-268632093>") 'next-window-next-buffer)
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

; Org
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'org-indent-mode) ; does this toggle?
(setq org-directory "~/git/org/")
(setq org-capture-templates
      '(("s" "SICP Exercise" entry
         (file "~/git/thoelze1.github.io/org/sicp-exercises.org")
         "* %?")
        ("j" "Journal" entry
         (file (lambda () (concat org-directory "journal.org")))
         "* %U\n%?")
        ("q" "Quote" entry
         (file (lambda () (concat org-directory "quotes.org")))
         "* %?")
        ("e" "Emacs feature" entry
         (file+headline (lambda () (concat org-directory "projects.org")) "Emacs features")
         "* TODO %?")
        ("p" "Project" entry
         (file (lambda () (concat org-directory "projects.org")))
         "* TODO %?")
        ("l" "Log" entry
         (file (lambda () (concat org-directory "log.org")))
         "* %U\n%?")
        ("r" "Book" entry
         (file+headline (lambda () (concat org-directory "reading.org")) "Books")
         "* TODO %?")
        ("m" "Miscellaneous" entry
         (file (lambda () (concat org-directory "misc.org")))
         "* TODO %?" nil nil)
        ("b" "Blog post ideas" entry
         (file (lambda () (concat org-directory "blog.org")))
         "* %? ")
        ("w" "Websites" entry
         (file+headline (lambda () (concat org-directory "reading.org")) "Websites")
         "* %? ")))
;; Also C-c ' is super useful
(setq org-src-tab-acts-natively t) ;; Src block indentation was horrible
(setq org-src-window-setup 'current-window)
(setq org-todo-keywords
      '((sequence "TODO" "|" "DONE" "CANCELED")))
(setq org-default-notes-file (concat org-directory "misc.org"))
(setq org-agenda-files '("~/git/org" "~/git/org/wiki" "~/git/thoelze1.github.io/org"))
(setq org-refile-targets '((org-agenda-files :maxlevel . 4)))
(setq org-refile-use-outline-path 'file)
(setq inferior-lisp-program "/opt/local/bin/sbcl")
(setq org-twbs-head "
<link  href=\"https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css\" rel=\"stylesheet\">
<script src=\"https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js\"></script>
<script src=\"https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js\"></script>")
;; (setq org-twbs-preamble-format '(("en" "<p class=\"author\">%t</p>")))
(setq org-export-with-toc 2)
(setq org-publish-project-alist
         `(("thoelze1.github.io"
            :base-directory "~/git/thoelze1.github.io/org"
            :recursive t
            :publishing-directory "~/git/thoelze1.github.io"
            :publishing-function org-twbs-publish-to-html
            :html-preamble t
            ;; :with-toc 2
            ;;:with-toc nil
            ;;:html-postamble nil
            ;; :section-numbers nil
            :with-headline-numbers nil
            ;;:with-timestamps nil
            )))
(defun org-back-to-indentation ()
  "Move to start of text on current line"
  (interactive)
  (if (org-at-heading-p)
      (let ()
        (beginning-of-line)
        (re-search-forward (concat "^\\(?:" outline-regexp "\\)")p
                           nil t))
    (back-to-indentation)))
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "<C-M-return>") 'org-insert-subheading)))
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "M-m") 'org-back-to-indentation)))
(global-set-key (kbd "H-c") 'org-capture)
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c r") 'org-refile)
(global-set-key (kbd "C-c a") 'org-agenda)
(org-babel-do-load-languages
 'org-babel-load-languages '((scheme . t)))
(setq org-list-allow-alphabetical t)

; Spotify
(define-key spotify-mode-map (kbd "C-c .") 'spotify-command-map)
