;; This is a minimal configuration file for emacs whose only job is to
;; load the literal configuration file.

(require 'org)
(org-babel-load-file
 (expand-file-name
  ;; This file cannot be named init.org:
  ;; https://raindev.io/blog/how-to-not-write-emacs-config-in-org/
  "~/.emacs.d/tanner.org"))
