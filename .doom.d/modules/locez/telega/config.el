;;; locez/telega/config.el -*- lexical-binding: t; -*-

(use-package! telega
  :commands telega
  :config
  (telega-mode-line-mode 1)
  (set-popup-rule! (regexp-quote telega-root-buffer-name)
    :side 'right :size 60 :quit nil :modeline t :select t)

  (set-popup-rule! "^◀[[({<].*[\])>}]$"
    :side 'right :size 60 :quit nil :modeline t :select t)

  (setq telega-chat-fill-column 47
        telega-chat-button-width 47
        telega-emoji-use-images nil
        telega-chat-show-deleted-messages-for '(not saved-messages))

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
