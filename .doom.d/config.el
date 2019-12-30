;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;;(set-popup-rule! "Treemacs\-*" :ignore t :quit nil :ttl nil :autosave t :side 'left)
(load! "lib/tools")

(setq lsp-ui-doc-use-webkit t)

(use-package! liberime-config
  :init
  (setq liberime-user-data-dir (concat doom-private-dir "etc/rime")))

(use-package! pyim
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
  (setq-default pyim-english-input-switch-functions
                '(pyim-probe-dynamic-english
                  pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template))
  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))
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

  (add-hook! telega-chat-mode
    (+word-wrap-mode t))
 

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
