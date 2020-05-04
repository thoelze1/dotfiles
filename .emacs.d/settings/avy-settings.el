;; avy stuff
;; https://github.com/abo-abo/avy/wiki/defcustom
(setq avy-keys '(?f ?j ?d ?k ?s ?l ?a ?\; ?' ?v ?n ?c ?m ?x ?, ?z
                 ?. ?b ?/ ?t ?u ?r ?i ?e ?o ?w ?p ?q ?\[ ?5 ?7 ?4
                 ?8 ?3 ?9 ?2 ?0 ?1 ?- ?6 ?= ?\] ?\\ ?` ?F ?J ?D ?K
                 ?S ?L ?A ?: ?\" ?V ?N ?C ?M ?X ?< ?Z ?> ?B ?? ?T
                 ?U ?R ?I ?E ?O ?W ?P ?Q ?{ ?% ?& ?$ ?* ?# ?\( ?@
                 ?\) ?! ?_ ?^ ?+ ?} ?| ?~))
(setq avy-case-fold-search nil)
(global-set-key (kbd "H-a") 'avy-goto-char)
(provide 'avy-settings)
