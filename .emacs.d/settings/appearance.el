(setq initial-buffer-choice "~/git")

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(add-to-list 'default-frame-alist '(undecorated . t))
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(font . "SF Mono-12"))

;; set transparency
;; https://lwn.net/Articles/88179/
;; first value is for active frame, second value is for inactive frame
(set-frame-parameter (selected-frame) 'alpha '(99 100))

(provide 'appearance)
