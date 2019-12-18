;; This is the global behavior in OSX so we'll keep that for emacs
(global-set-key (kbd "<s-backspace>") (lambda ()
                                        (interactive)
                                        (kill-line 0)))

;; I have karabiner map space to fn globally. I then have emacs map fn
;; to hyper. However, OSX translates some keychords containing fn into
;; keychords without the fn key. I know of two such cases: fn+f3
;; translates to f3 (as do the other numbered fn keys) and fn+<left>
;; translates to <home> (the other arrows keys have similar
;; translations). Therefore, some of the keybindings below use the the
;; translation from OSX instead of a chord with H (<home> instead of
;; <H-left>, for example)
(setq ns-function-modifier 'hyper)

;; Note how many bindings we can have for number keys! First, we have
;; 10 number keys and 10 numbered function keys. We then have 5
;; modifiers (control, shit, meta, super, hyper) which can be chorded,
;; and then for the function-number keys (f1, f2 etc) we have 4
;; modifiers! Supposing we can reasonably use 3 modifiers with a
;; keypress, that's 1 + 5 + 10 + 10 = 26 ways of pressing a number
;; key, and 1 + 5 + 10 = 15 ways of pressing a numbered function key
;; for a total of 26 + 15 = 41 ways of pressing a generic "number"
;; key. Insane!
(global-set-key (kbd "H-0") 'delete-window)
(global-set-key (kbd "H-1") 'delete-other-windows)
(global-set-key (kbd "H-2") 'split-window-below)
(global-set-key (kbd "H-3") 'split-window-right)
(global-set-key (kbd "<home>") 'previous-buffer)
(global-set-key (kbd "<end>") 'next-buffer)
(global-set-key (kbd "H-g") 'magit-status)
(require 'jump-char)
(global-set-key (kbd "H-j") 'jump-char-forward)
(global-set-key (kbd "H-J") 'jump-char-backward)
(global-set-key (kbd "<S-f3>") 'kmacro-end-macro)
(global-set-key (kbd "H-o") 'other-window)
(global-set-key (kbd "H-4") 'cpp-panes)
(global-set-key (kbd "H-c") 'mc/edit-lines)

;; Move more quickly. I took this from magnars; I'm not sure I like
;; these mods, maybe I'll trash or rebind with hyper...
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

(provide 'key-bindings)
