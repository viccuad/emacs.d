;;;; ~/.spaceemacs.d/ -- viccuad's Emacs configuration -*- no-byte-compile: t -*-
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

;;;; COLORS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (add-hook 'css-mode-hook 'rainbow-mode)  ;; Rainbow mode for css automatically


;;;; FLYSPELL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq ispell-dictionary "english")
  ;; TODO enable spell checking for text modes

;;;; FILE TYPES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; prog-mode
  ;; (add-hook 'prog-mode-hook
  ;;   (lambda ()
  ;;     (font-lock-add-keywords nil
  ;;     '(("\\<\\(FIXME\\|TODO\\|BUG\\):" 1 font-lock-warning-face t)))))

  ;; text-mode
  (add-hook 'text-mode-hook 'auto-fill-mode)

  ;; Makefile
  (add-hook 'makefile-mode-hook 'whitespace-mode)

  ;; C-C++
  (setq c-default-style "linux") ;; or k&r for example
  (with-eval-after-load 'projectile
    (push '("C" "h") projectile-other-file-alist)) ;; make projective jump from .C to .h files and viceversa
  (add-hook 'c-mode-hook (lambda () (setq comment-start "//"
                                          comment-end   ""))) ;; make comments with // instead of /**/

  ;; Python
  (add-to-list 'auto-mode-alist '("\\.gd$" . python-mode))
  (setq python-check-command "flake8") ;; check syntax after every save

  ;; LATEX
  ;; automatically update pdf preview on each recompile
  (add-hook 'doc-view-mode-hook 'auto-revert-mode)

  ;; (setq TeX-show-compilation t)
  (setq TeX-source-correlate-mode t) ;; enable synctex, .pdf to .tex backward search
  (setq TeX-source-correlate-start-server t)
  (setq TeX-source-correlate-method 'synctex)

;;;; ORG-MODE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(with-eval-after-load 'org
  ;; my org config:
  (setq org-agenda-files (list "")
        org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE"))
        ;; http://members.optusnet.com.au/~charles57/GTD/gtd_workflow.html
        org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("debian" . ?l)))
  )

(setq org-agenda-files '("~/org"))
;; (setq org-agenda-files '("~/Debian/debian.org" "/home/vic/org/hoy.org"))

;;;; GIT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-git-commit-mode t) ;; use spacemacs as $EDITOR for editing git commit messages:

;;;; FLYCHECK ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (require 'flycheck)

  (flycheck-define-checker proselint
    "A linter for prose."
    :command ("proselint" source-inplace)
    :error-patterns
    ((warning line-start (file-name) ":" line ":" column ": "
              (id (one-or-more (not (any " "))))
              (message (one-or-more not-newline)
                       (zero-or-more "\n" (any " ") (one-or-more not-newline)))
              line-end))
    :modes (text-mode markdown-mode gfm-mode))
  (add-to-list 'flycheck-checkers 'proselint)

  (require 'flycheck-checkbashisms)
  (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-checkbashisms-setup))

  ;; Check 'echo -n' usage
  (setq flycheck-checkbashisms-newline t)

  ;; Check non-POSIX issues but required to be supported  by Debian Policy 10.4
  ;; Setting this variable to non nil made flycheck-checkbashisms-newline effects
  ;; regardless of its value
  (setq flycheck-checkbashisms-posix t)
