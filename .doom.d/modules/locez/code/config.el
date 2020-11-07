;;; locez/code/config.el -*- lexical-binding: t; -*-


(use-package! rainbow-fart
  :config
  (setq rainbow-fart-voice-model "JustKowalski")
  (setq rainbow-fart-keyword-interval (* 1 10)))


(setq +format-on-save-enabled-modes
      '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
            sql-mode         ; sqlformat is currently broken
            tex-mode         ; latexindent is broken
            latex-mode
            java-mode))
