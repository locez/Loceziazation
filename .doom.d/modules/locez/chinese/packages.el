;; -*- no-byte-compile: t; -*-
;;; locez/chinese/packages.el

(package! liberime :recipe
  (:host github
    :repo "merrickluo/liberime"
    :branch "master"
    :files ("CMakeLists.txt" "Makefile" "src" "liberime*.el" "liberime-config.el" "emacs-module")))
