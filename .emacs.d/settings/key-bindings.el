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

(provide 'key-bindings)
