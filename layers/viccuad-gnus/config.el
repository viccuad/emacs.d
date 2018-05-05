;;;; ~/.emacs.d/ -- viccuad's Emacs configuration     -*- no-byte-compile: t -*-
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Notmuch options
  (setq notmuch-search-oldest-first nil
        notmuch-crypto-process-mime t)
  (define-key global-map "\C-cn" 'notmuch)

;;  (setq notmuch-saved-searches
;;        '((:name "inbox"
;;                ;; :query "tag:inbox AND (folder:INBOX or folder:INBOX.Eyeo)")
;;                :query "tag:inbox AND folder:INBOX")
;;          (:name "unread" :query "tag:unread" :key "u")
;;          (:name "flagged" :query "tag:flagged" :key "f")
;;          (:name "sent" :query "tag:sent" :key "t")
;;          (:name "drafts" :query "tag:draft" :key "d")
;;          (:name "all mail" :query "*" :key "a"))
;;  (eval-after-load "notmuch"
;;    (lambda ()
;;      (define-key notmuch-common-keymap "g" 'notmuch-refresh-this-buffer)
;;      (define-key 'notmuch-show-part-map "d" 'my-notmuch-show-view-as-patch)))
 
;; Modline incoming message notifications
;; (setq viccuad/notmuch-activity-string "")
;; (add-to-list 'global-mode-string '((:eval viccuad/notmuch-activity-string)) t)
;; (defun viccuad/get-notmuch-incoming-count ()
;;   (string-trim
;;    (shell-command-to-string
;;     "notmuch count tag:inbox AND tag:unread AND '\(folder:INBOX or folder:INBOX.Eyeo\)'")))
;; (defun viccuad/format-notmuch-mode-string (count)
;;   (concat " 📧[" (if (string= count "0") "" count) "]"))
;; (defun viccuad/update-notmuch-activity-string (&rest args)
;;   (setq viccuad/notmuch-activity-string
;;         (viccuad/format-notmuch-mode-string (viccuad/get-notmuch-incoming-count)))
;;   (force-mode-line-update))
;; (add-hook 'notmuch-after-tag-hook 'viccuad/update-notmuch-activity-string)
;; (defcustom notmuch-presync-hook nil
;;   "Hook run before notmuch is synchronised"
;;   :type 'hook)
;; (defcustom notmuch-postsync-hook '(viccuad/update-notmuch-activity-string)
;;   "Hook run after notmuch has been synchronised"
;;   :type 'hook)
;;

;; view as patch https://notmuchmail.org/emacstips/#index25h2
  (defun my-notmuch-show-view-as-patch ()
    "View the the current message as a patch."
    (interactive)
    (let* ((id (notmuch-show-get-message-id))
          (msg (notmuch-show-get-message-properties))
          (part (notmuch-show-get-part-properties))
          (subject (concat "Subject: " (notmuch-show-get-subject) "\n"))
          (diff-default-read-only t)
          (buf (get-buffer-create (concat "*notmuch-patch-" id "*")))
          (map (make-sparse-keymap)))
      (define-key map "q" 'notmuch-bury-or-kill-this-buffer)
      (switch-to-buffer buf)
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert subject)
        (insert (notmuch-get-bodypart-text msg part nil)))
      (set-buffer-modified-p nil)
      (diff-mode)
      (lexical-let ((new-ro-bind (cons 'buffer-read-only map)))
                  (add-to-list 'minor-mode-overriding-map-alist new-ro-bind))
      (goto-char (point-min))))

;; gnus-alias
;;  (autoload 'gnus-alias-determine-identity "gnus-alias" "" t)
;;  (setq gnus-alias-identity-alist
;;       '(("viccuad"
;;          nil ;; Does not refer to any other identity
;;          "Víctor Cuadrado gnusalias <me@viccuad.me>"
;;          nil ;; No organization header
;;          nil ;; No extra headers
;;          nil ;; No extra body text
;;          "~/.dotfiles/mail/nostow/viccuad_signature")
;;         ("victorcuad"
;;          nil
;;          "Víctor Cuadrado Juan <victorcuad@gmail.com>"
;;          nil ;; No organization header
;;          nil ;; No extra headers
;;          nil ;; No extra body text
;;          "~/.dotfiles/mail/nostow/victorcuad_signature")))
;;  (setq gnus-alias-default-identity "viccuad")
;;  (add-hook 'message-setup-hook
;;           (lambda ()
;;             (gnus-alias-determine-identity)
;;             (define-key message-mode-map (kbd "C-c f")
;;               'gnus-alias-select-identity)
;;             (flyspell-mode)))
;; ;;(setq gnus-alias-identity-rules
;; ;;      '(("@adblockplus.org" ("any" "@adblockplus\\.org" both) "eyeo")
;; ;;        ("@eyeo.com" ("any" "@eyeo\\.com" both) "eyeo")))
;; (setq user-mail-address "me@viccuad.me"
;;  user-full-name "Víctor Cuadrado")

;; Setup emacs Mail User Agent header:
  (setq
    mail-user-agent 'message-user-agent)
  ;; Setup message-user-agent options:
  (setq
    message-directory "~/.mail/meviccuadme/Drafts"  ;; save drafts here TODO doesn't work
    message-kill-buffer-on-exit t)                    ;; kill buffer after sending mail
    (add-hook 'message-send-hook 'mml-secure-message-sign-pgpmime)

  ;; (setq browse-url-browser-function 'browse-url-generic
  ;;   browse-url-generic-program "firefox")

;; Setup mail sender
  (setq
    message-send-mail-function 'message-send-mail-with-sendmail
 ;; sendmail-program "/home/vic/.dotfiles/mail/nostow/bin/msmtpq"
    sendmail-program "msmtpq"
    mail-specify-envelope-from t
    ;; needed for debians message.el cf. README.Debian.gz
    message-sendmail-f-is-evil t
    ;; provide sendmail with the msmtp account we are using
    message-sendmail-extra-arguments '("--read-envelope-from")
    )

    ;; mail-envelope-from 'header
    ;; message-sendmail-envelope-from 'header)

;; Setup Fcc to save sent messages
  ;; only 1 Fcc:
  (setq notmuch-fcc-dirs "meviccuadme/Sent")
  ;; Several Fccs depending on account: TODO, is a list
  ;;(setq notmuch-fcc-dirs
  ;;    (("me@viccuad.me" . "meviccuadme/Sent")
  ;;     ("spaetz@sspaeth.de" . "OUTBOX.OSS")
  ;;     (".*" . "defaultinbox")))
