;; This is a minimal configuration file for emacs whose sole job is to
;; load the literal configuration file.
;;
;; Note: since this file is named init.el, the literate configuration
;; file cannot be named init.org due to a circular dependency caused
;; by org-babel-tangle-file

(require 'org)
(org-babel-load-file "~/.emacs.d/init_.org")
