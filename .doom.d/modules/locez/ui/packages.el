;; -*- no-byte-compile: t; -*-
;;; locez/ui/packages.el

(package! eaf :recipe
  (:host github
    :repo "manateelazycat/emacs-application-framework"
    :branch "master"
    :files ("app" "core" "docker" "screenshot" "eaf.py" "*.el")))
