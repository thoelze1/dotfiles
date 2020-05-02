(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'org-indent-mode) ; does this toggle?

(setq org-directory "~/git/org/")
(setq org-capture-templates
      '(("j" "Journal" entry
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
(setq org-default-notes-file (concat org-directory "misc.org"))
(setq org-agenda-files '("~/git/org"))
(setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
(setq org-refile-use-outline-path 'file)
(setq inferior-lisp-program "/opt/local/bin/sbcl")
(setq org-publish-project-alist
      `(("thoelze1.github.io"
         :base-directory "~/git/thoelze1.github.io/org"
         :recursive t
         :publishing-directory "~/git/thoelze1.github.io"
         :publishing-function org-html-publish-to-html
         :with-toc nil
         :html-postamble nil
         :section-numbers nil
         :with-timestamps nil)))

(provide 'org)
