;; https://github.com/clojure-vim/vim-cider#using
(swap! boot.repl/*default-dependencies*
       concat '[[cider/cider-nrepl "0.20.0"]
                [refactor-nrepl "2.4.0"]])

(swap! boot.repl/*default-middleware* conj
       'cider.nrepl/cider-middleware
       'refactor-nrepl.middleware/wrap-refactor)

(set-env! :dependencies '[[sparkfund/boot-lein "0.4.0"]
                          [vvvvalvalval/scope-capture "0.3.2"
                           :exclusions [org.clojure/clojure]]])

;; for boot in IntelliJ
;; boot-lein: `boot write-project-clj` task directly accessible
(require '[sparkfund.boot-lein :refer [write-project-clj]])

(require 'sc.api)
