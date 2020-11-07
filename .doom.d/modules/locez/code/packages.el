;; -*- no-byte-compile: t; -*-
;;; locez/code/packages.el

(package! rainbow-fart :recipe
  (:host github
   :repo "stardiviner/emacs-rainbow-fart"
   :branch "master"
   :files ("*.el" "voices")))

(package! protobuf-mode :recipe
  (:host github
   :repo "emacsmirror/protobuf-mode"
   :files ("protobuf-mode.el")))
