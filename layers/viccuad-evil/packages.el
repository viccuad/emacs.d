;;; packages.el --- viccuad-evil layer packages file for Spacemacs.
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
;; added to `viccuad-evil-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `viccuad-evil/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `viccuad-evil/pre-init-PACKAGE' and/or
;;   `viccuad-evil/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst viccuad-evil-packages
  '(
    evil-terminal-cursor-changer ;; has been temporarily disabled https://github.com/7696122/evil-terminal-cursor-changer/issues/8
    )
  )


(defun viccuad-evil/init-evil-terminal-cursor-changer ()
  (use-package evil-terminal-cursor-changer
    :config
    (unless (display-graphic-p)
      (require 'evil-terminal-cursor-changer)
      (evil-terminal-cursor-changer-activate) ; or (etcc-on)
      )
    )
  )

;;; packages.el ends here
