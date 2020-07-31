;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;;(set-popup-rule! "Treemacs\-*" :ignore t :quit nil :ttl nil :autosave t :side 'left)

(setq doom-theme 'doom-girly-heart)
(load! "lib/tools")

(use-package! eaf)
(use-package! ebuild-mode)


(use-package! rainbow-fart
  :config
  (setq rainbow-fart-voice-model "JustKowalski")
  (setq rainbow-fart-keyword-interval (* 1 10)))

(after! lsp-python-ms
  (set-lsp-priority! 'mspyls 1))


;; FIXME Fix for emacs 27
;; https://github.com/emacs-lsp/lsp-mode/issues/1778
;; (setq lsp-gopls-codelens nil)

(setq org-pandoc-options-for-gfm '((wrap . "none")))
(add-hook! org-mode
    (activate-input-method "pyim"))

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
                  pyim-probe-punctuation-after-english-letter))


  (liberime-try-select-schema "luna_pinyin_simp")
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



(map! :leader :desc "Switch buffer" "," 'switch-to-buffer)
(map! :leader :desc "Switch workspace buffer" "<" 'persp-switch-to-buffer)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#FDF0ED" "#E95678" "#3FDAA4" "#FAB795" "#26BBD9" "#EE64AC" "#6BE4E6" "#333333"])
 '(custom-safe-themes
   '("9356c9d84f336968d73113027f8dc3a50d9c21429dab8fa8565cf0077d5c9205" "8a0b66f8462d9f8d773517abbf31e209cd5906164c4e3021dff4a118647f3589" "1159fa2957e492dbccc044615042204d9d7d9d394d5962999f3ab303033e238d" "baecd40a344e21d63198d72d9d7877ee8250bb11f1d84d4b16cfe9d4f3870636" "bf3b39be7219badbccaf91b2279549d40c40eb12bdd995e399f1d65bc6cc9597" "774765e60587689f3fe400a73a6feddfa32cd72904926ef57ff27573c47e092b" "c5c37b861c485fd9cca1ca8f8d4f273564231b2bd47720c5ffdf6460257d475a" "fecce6dfd7a8d481b7aac7c30fd355cff1a2a3b52ee71a9607667de1c1c6a1fa" "851837777f47c51c05c974eda504e9ecf67eef396b2394b4af837776c808baaa" "af744d55244fcbf258edde277c30bf9d0ac5316da9e66a4d016d1fa391cea285" "af0611b3adbb490cf5b730de646265adbd3bb0d0778292c6964c88e42b373825" "a3afdc4f004541635e0bd267e27b9f9ecd271258745d9c81ad5ef7bf3417aea7" default))
 '(fci-rule-color "#f9cec3")
 '(jdee-db-active-breakpoint-face-colors (cons "#1EAEAE" "#E95678"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1EAEAE" "#3FDAA4"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1EAEAE" "#6a6a6a"))
 '(objed-cursor-color "#E95678")
 '(pdf-view-midnight-colors (cons "#333333" "#FDF0ED"))
 '(rustic-ansi-faces
   ["#FDF0ED" "#E95678" "#3FDAA4" "#FAB795" "#26BBD9" "#EE64AC" "#6BE4E6" "#333333"])
 '(vc-annotate-background "#FDF0ED")
 '(vc-annotate-color-map
   (list
    (cons 20 "#3FDAA4")
    (cons 40 "#7dce9f")
    (cons 60 "#bbc29a")
    (cons 80 "#FAB795")
    (cons 100 "#f6ab8f")
    (cons 120 "#f39f89")
    (cons 140 "#f09383")
    (cons 160 "#ef8390")
    (cons 180 "#ee739e")
    (cons 200 "#EE64AC")
    (cons 220 "#ec5f9a")
    (cons 240 "#ea5a89")
    (cons 260 "#E95678")
    (cons 280 "#c95b74")
    (cons 300 "#a96071")
    (cons 320 "#89656d")
    (cons 340 "#f9cec3")
    (cons 360 "#f9cec3")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
