;;;; ~/.spacemacs.d/ -- viccuad's Emacs configuration -*- no-byte-compile: t -*-
;;
;; Copyright (C) 2018
;; Victor Cuadrado

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(setq
 evil-escape-key-sequence "jk" ;; but also use evil-escape to escape from "everything" in Emacs
 evil-want-fine-undo nil ;; use vim undo, to undo last insert mode as a chunk:
 evil-move-cursor-back nil ;; don't move cursor back when going to normal mode from insert
 evil-shift-round nil ;; this makes possible to put the shifting back how it was when using > and then <
 )

;; prevent visual selections to override system clipboard:
(fset 'evil-visual-update-x-selection 'ignore)

;; Make v$ exclude the carriage return
;(evil-define-motion evil-last-non-blank (count)
;  :type inclusive
;  (evil-end-of-line count)
;  (re-search-backward "^\\|[^[:space:]]")
;  (setq evil-this-type (if (eolp) 'exclusive 'inclusive)))
;(define-key evil-visual-state-map "$" 'evil-last-non-blank)
