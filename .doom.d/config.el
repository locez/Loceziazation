;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;;(set-popup-rule! "Treemacs\-*" :ignore t :quit nil :ttl nil :autosave t :side 'left)
(load! "lib/tools")

(use-package! eaf)

(setq org-pandoc-options-for-gfm '((wrap . "none")))
(add-hook! org-mode
    (activate-input-method "pyim"))

(use-package! liberime-config
  :init
  (setq liberime-user-data-dir (concat doom-private-dir "etc/rime")))

(use-package! pyim
  :init
  (setq pyim-title "ㄓ")

  :commands pyim-convert-string-at-point
  :bind
  (("M-]" . pyim-convert-string-at-point))
  
  :config
  (if (display-graphic-p)
      (setq pyim-page-tooltip 'posframe)
    (setq pyim-page-tooltip 'popup))
  (setq default-input-method "pyim"
        pyim-default-scheme 'rime
        pyim-page-length 9
        pyim-dicts
        `((:name
           "pyim-bigdict"
           :file
           ,(expand-file-name (concat doom-private-dir "etc/pyim/pyim-bigdict.pyim.gz")))))

  (defun or-funcs (fn-list)
    (if (not fn-list)
        nil
      (if (or (funcall (car fn-list)))
          t
        (or-funcs (cdr fn-list)))))

  (defun pyim-switch-rules ()
    (let ((rule-list '(pyim-probe-isearch-mode pyim-probe-program-mode)))
      (if (or (derived-mode-p 'telega-chat-mode) (derived-mode-p 'org-mode))
          (push 'pyim-probe-auto-english rule-list)
        (progn
            (push 'pyim-probe-dynamic-english rule-list)
            (push 'pyim-probe-org-structure-template rule-list)))
      (or-funcs rule-list)))

  (setq-default pyim-english-input-switch-functions
                '(pyim-switch-rules))

  (defun pyim-probe-punctuation-after-english-letter (char)
    (let ((str-before-1 (pyim-char-before-to-string 0))
          (puncts (mapcar 'car pyim-punctuation-dict)))
      (and (string-match "[A-Za-z ]" str-before-1)
           (member (char-to-string char) puncts))))

  
  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation
                  pyim-probe-punctuation-after-english-letter))


  (liberime-select-schema "luna_pinyin_simp")
  (pyim-isearch-mode 1))

(use-package! telega
  :commands telega
  :config
  (telega-mode-line-mode 1)
  (set-popup-rule! (regexp-quote telega-root-buffer-name)
    :side 'right :size 60 :quit nil :modeline t :select t)

  (set-popup-rule! "^◀[[({<].*[\])>}]$"
    :side 'right :size 60 :quit nil :modeline t :select t)

  (setq telega-chat-fill-column 47
        telega-chat-button-width 47)

  ;; Sarasa Mono SC can make font align correctly,
  ;; even with mixed Chinese and English
  (when (member "Sarasa Mono SC" (font-family-list))
    (make-face 'telega-align-by-sarasa)
    (set-face-font 'telega-align-by-sarasa (font-spec :family "Sarasa Mono SC"))
    (add-hook! '(telega-chat-mode-hook telega-root-mode-hook)
      (buffer-face-set 'telega-align-by-sarasa)))

  (add-hook! telega-chat-mode
    (visual-line-mode t)
    ((lambda () (run-at-time nil nil #'activate-input-method "pyim"))))

  (after! all-the-icons
    (add-to-list 'all-the-icons-mode-icon-alist
                 '(telega-root-mode all-the-icons-fileicon "telegram"
                                    :heigt 1.0
                                    :v-adjust -0.2
                                    :face all-the-icons-yellow))

    (add-to-list 'all-the-icons-mode-icon-alist
                 '(telega-chat-mode all-the-icons-fileicon "telegram"
                                    :heigt 1.0
                                    :v-adjust -0.2
                                    :face all-the-icons-blue))))



(map! :leader :desc "Switch buffer" "," 'switch-to-buffer)
(map! :leader :desc "Switch workspace buffer" "<" 'persp-switch-to-buffer)
