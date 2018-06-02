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

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `viccuad-look-n-feel-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `viccuad-look-n-feel/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `viccuad-look-n-feel/pre-init-PACKAGE' and/or
;;   `viccuad-look-n-feel/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst viccuad-look-n-feel-packages
  '(
    )
  )

;; (defun viccuad-look-n-feel/post-init-projectile ()
;;   (setq projectile-switch-project-action 'neotree-projectile-action))

;;; packages.el ends here
