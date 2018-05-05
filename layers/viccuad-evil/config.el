
(setq
 evil-escape-key-sequence "jk" ;; but also use evil-escape to escape from "everything" in Emacs
 evil-want-fine-undo nil ;; use vim undo, to undo last insert mode as a chunk:
 evil-move-cursor-back nil ;; don't move cursor back when going to normal mode from insert
 evil-shift-round nil ;; this makes possible to put the shifting back how it was when using > and then <
 )

;; prevent visual selections to override system clipboard:
(fset 'evil-visual-update-x-selection 'ignore)

;; make j & k behave as g j & g k:
;(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
;(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;; Make v$ exclude the carriage return
;(evil-define-motion evil-last-non-blank (count)
;  :type inclusive
;  (evil-end-of-line count)
;  (re-search-backward "^\\|[^[:space:]]")
;  (setq evil-this-type (if (eolp) 'exclusive 'inclusive)))
;(define-key evil-visual-state-map "$" 'evil-last-non-blank)
