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

;; ruler ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq
  fci-rule-column 81 ;; +1 because the utf char is to the left
  fci-always-use-textual-rule t
  fci-rule-character ?\u258E ;; left 1/4 block
)

;; Activate column indicator as global mode, except for org-mode:
;; (add-hook 'prog-mode-hook 'turn-on-fci-mode)
;; (add-hook 'text-mode-hook 'turn-on-fci-mode)
;; (add-hook 'org-mode-hook 'turn-off-fci-mode 'append)


;; colors and faces ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; backport fix for tmux-256color:
  ;; https://lists.gnu.org/archive/html/emacs-devel/2016-12/msg00990.html
  (require 'term/xterm)
  (defcustom xterm-tmux-extra-capabilities '(modifyOtherKeys)
       "Extra capabilities supported under \"tmux\".
      ;; Some features of tmux depend on the terminal emulator in which
      ;; It runs, which can change when the tmux session is moved to another tty."
       :version "26.1"
       :type xterm--extra-capabilities-type
       :group 'xterm)

  (defun terminal-init-tmux ()
       "Terminal initialization function for tmux."
       ;; Treat a tmux terminal similar to an xterm, but don't use
       ;; xterm-extra-capabilities's `check' setting since that doesn't seem
       ;; to work so well (it depends too much on the surrounding terminal
       ;; emulator, which can change during the session, bug#20356).
       (let ((xterm-extra-capabilities xterm-tmux-extra-capabilities))
              (tty-run-terminal-initialization (selected-frame) "xterm")))

;; pretty window borders
(let ((display-table (or standard-display-table (make-display-table))))
  (set-display-table-slot display-table 'vertical-border (make-glyph-code ?│))
  (setq standard-display-table display-table))

;; miscelanea ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(blink-cursor-mode t)

;;;; CLIPBOARD ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; use xclip to make system clipboard available:
(unless window-system
     (when (getenv "DISPLAY")
       (defun xclip-cut-function (text &optional push)
         (with-temp-buffer
           (insert text)
           (call-process-region (point-min) (point-max) "xclip" nil 0 nil "-i" "-selection" "clipboard")))
       (defun xclip-paste-function()
         (let ((xclip-output (shell-command-to-string "xclip -o -selection clipboard")))
           (unless (string= (car kill-ring) xclip-output)
             xclip-output )))
       (setq interprogram-cut-function 'xclip-cut-function)
       (setq interprogram-paste-function 'xclip-paste-function)
       ))

;;;; SPACEMACS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;       ;; (spacemacs/toggle-evil-cleverparens-on)
;;       ;; (spacemacs/toggle-aggressive-indent-globally-on)
;;
;;       ;; truncate lines in buffer (there is no hook for buffers and the setting is
;;       ;; buffer-local, so do it with other hooks):
;;       (add-hook 'prog-mode-hook 'spacemacs/toggle-truncate-lines-off)
;;       (add-hook 'text-mode-hook 'spacemacs/toggle-truncate-lines-off)
;;       ;; TODO after an autocompletion, the truncate-lines gets back on (open an issue)
;;
    (setq visible-bell t)  ;; Don't let Emacs hurt your ears
;;
;;       ;; TODO: persistent undo history: https://github.com/syl20bnr/spacemacs/issues/774
;;       (setq undo-tree-auto-save-history t
;;             undo-tree-history-directory-alist
;;             `(("." . ,(concat spacemacs-cache-directory "undo"))))
;;       (unless (file-exists-p (concat spacemacs-cache-directory "undo"))
;;         (Make-directory (concat spacemacs-cache-directory "undo")))
;;     
;;       ; Switch neotree root whenever the projectile project changes.
;;       (setq projectile-switch-project-action 'neotree-projectile-action)
;;     
;;     
;;     ;;;; CUSTOM FACES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     
;;       ;; for monokai
;;           ;; custom set faces for autocompletion pop-ups
;;           (custom-set-faces
;;           '(company-tooltip-common
;;             ((t (:inherit company-tooltip :weight bold :underline nil))))
;;           '(company-tooltip-common-selection
;;             ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
;;     
;;           (set-face-background 'linum  (face-attribute 'hl-line :background))
;;     
;;           (setq fci-rule-color "#292929")
;;           (set-face-background 'hl-line "#292929")
;;     
;;           (set-face-italic 'font-lock-comment-face t)
;;     
;;     
;;     ;;;; AVY ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     
;;       avy-all-windows 'all-frames
;;     
;;;; CUSTOM FACES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; for monokai
    ;; custom set faces for autocompletion pop-ups
    (custom-set-faces
    '(company-tooltip-common
      ((t (:inherit company-tooltip :weight bold :underline nil))))
    '(company-tooltip-common-selection
      ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))

    ;(set-face-background 'linum  (face-attribute 'hl-line :background)) ;; TODO BROKEN

    (setq fci-rule-color "#292929") ; https://github.com/syl20bnr/spacemacs/issues/8917
    (set-face-background 'hl-line "#292929")

    (set-face-italic 'font-lock-comment-face t)

;;     ;;;; SMARTPARENS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;     
;;       (setq-default
;;         sp-highlight-pair-overlay nil
;;         sp-highlight-wrap-overlay nil
;;         sp-highlight-wrap-tag-overlay nil)
;;     
;;     
;;     
;;;; LINUM and HL-LINE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq hl-line-sticky-flag nil) ;; highlights the line about point in the selected window only

  ;; Show line numbers, dynamically with spaces on either side:
  (defadvice linum-update-window (around linum-dynamic activate)
    (let* ((w (length (number-to-string
                       (count-lines (point-min) (point-max)))))
           (linum-format (concat " %" (number-to-string w) "d ")))
      ad-do-it))

;;;; GOLDEN RATIO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq golden-ratio-auto-scale t) ;; for wide screens

;;;; VC GUTTER ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq
   diff-hl-margin-side 'left
   diff-hl-margin-mode t ;; so it works in TUI
   )

;;;; WHITESPACE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; (setq-default
  ;;  whitespace-line-column 80)

  (setq whitespace-style '(
                           ;; via display table:
                           ;; space-mark
                           ;; tab-mark
                           ;; newline-mark
                           face
                           ;; spaces         ;; SPACEs and HARD SPACEs
                           ;; lines          ;; lines that go past whitespace-line-column
                           ;; lines-tail     ;; part of lines that go past whitespace-line-column
                           tabs
                           newline
                           empty             ;; empty lines at beginning and end of buffer
                           trailing
                           ;; evaluated in this order:
                           indentation                ;; either 8 or more spaces, or tabs, depending on indent-tab-mode
                           indentation::tab        ;; tabs at beginning of line
                           ;; indentation::space      ;; 8 or more spaces at beginning of line
                           ;; evaluated in this order:
                           space-after-tab            ;; 8 or more SPACEs after a TAB, if ‘indent-tabs-mode’ (which see) is non-nil; otherwise tabs
                           ;; space-after-tab::tab    ;; 8 or more SPACEs after a TAB
                           ;; space-after-tab::space  ;; TABs are visualized when occurs 8 or more SPACEs after a TAB
                           ;; evaluated in this order:
                           space-before-tab           ;; SPACEs before TAB, if ‘indent-tabs-mode’ (which see) is non-nil; otherwise, TABs
                           ;; space-before-tab::tab   ;; SPACEs before TAB
                           ;; space-before-tab::space ;; TABs are visualized when occurs SPACEs before TAB
                           )
        whitespace-display-mappings '(
                                      (space-mark 32 [183] [46]) ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
                                      (newline-mark 10 [8629 10]) ; 10 LINE FEED
                                      (tab-mark 9 [8594 9] [92 9])
                                      )
        )

