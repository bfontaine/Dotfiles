;; https://github.com/clojure-vim/vim-cider#using
(swap! boot.repl/*default-dependencies*
       concat '[[cider/cider-nrepl "0.20.0"]
                [refactor-nrepl "2.4.0"]])

(swap! boot.repl/*default-middleware* conj
       'cider.nrepl/cider-middleware
       'refactor-nrepl.middleware/wrap-refactor)

;; for boot in IntelliJ
(set-env! :dependencies '[[sparkfund/boot-lein "0.4.0"]])
;; boot-lein: `boot write-project-clj` task directly accessible
(require '[sparkfund.boot-lein :refer [write-project-clj]])

(set-env! :dependencies #(conj % '[vvvvalvalval/scope-capture "0.3.2"]))
(require 'sc.api)
