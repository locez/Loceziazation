;;; locez/chinese/config.el -*- lexical-binding: t; -*-

(use-package! liberime
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
                  pyim-probe-punctuation-after-english-letter)))


(liberime-try-select-schema "luna_pinyin_simp")
(pyim-isearch-mode 1)
(add-hook! org-mode
    (activate-input-method "pyim"))
