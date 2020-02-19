;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)
(package! telega)
(package! liberime-config :recipe
  (:host github
    :repo "merrickluo/liberime"
    :branch "master"
    :files ("CMakeLists.txt" "Makefile" "src" "liberime-config.el")))
(package! eaf :recipe
  (:host github
    :repo "manateelazycat/emacs-application-framework"
    :branch "master"
    :files ("app" "core" "docker" "screenshot" "eaf.py" "eaf.el")))
