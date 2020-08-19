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
(provide 'org-settings)
