;;; packages.el --- viccuad-gnus layer packages file for Spacemacs.
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
;; added to `viccuad-gnus-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `viccuad-gnus/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `viccuad-gnus/pre-init-PACKAGE' and/or
;;   `viccuad-gnus/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst viccuad-gnus-packages
  '(
    w3m      ;; for gnus
    smtpmail ;; for gnus
    ;; gnus-notify ;;for gnus, notifications on the modeline
    highlight-chars ;; for tab, troll chars
    ;; org-notmuch.el
    notmuch ;; TODO I should use debian's packages
    gnus-alias ;; for messages.el aliases, used for notmuch
  )

;;; packages.el ends here
