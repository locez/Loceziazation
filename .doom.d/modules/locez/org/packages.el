;; -*- no-byte-compile: t; -*-
;;; locez/org/packages.el

(package! org-roam-server :recipe
  (:host github
   :repo "org-roam/org-roam-server"
   :branch "master"
   :files ("*.el" "assets" "index.html")))
