;;; packages.el --- viccuad-look-n-feel layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: vic <vic@clotho>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

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

;;; packages.el ends here
