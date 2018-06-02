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

;;;; COLORS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'css-mode-hook 'rainbow-mode)  ;; Rainbow mode for css automatically

;;;; FLYSPELL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq ispell-dictionary "english")

;;;; FILE TYPES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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

;;;; ORG-MODE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; (setq org-agenda-files '("~/org"))
;; (setq org-agenda-files '("~/Debian/debian.org" "/home/vic/org/hoy.org"))

;;;; GIT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;; FLYCHECK ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

