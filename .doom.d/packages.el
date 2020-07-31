;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)
(package! telega)
(package! liberime :recipe
  (:host github
    :repo "merrickluo/liberime"
    :branch "master"
    :files ("CMakeLists.txt" "Makefile" "src" "liberime*.el" "liberime-config.el" "emacs-module")))
(package! eaf :recipe
  (:host github
    :repo "manateelazycat/emacs-application-framework"
    :branch "master"
    :files ("app" "core" "docker" "screenshot" "eaf.py" "eaf.el")))
(package! ebuild-mode)

(package! rainbow-fart :recipe
  (:host github
   :repo "stardiviner/emacs-rainbow-fart"
   :branch "master"
   :files ("*.el" "voices")))
