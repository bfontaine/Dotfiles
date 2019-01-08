;; https://github.com/clojure-vim/vim-cider#using
(swap! boot.repl/*default-dependencies*
       concat '[[cider/cider-nrepl "0.19.0"]
                [refactor-nrepl "2.4.0"]])

(swap! boot.repl/*default-middleware* conj
       'cider.nrepl/cider-middleware
       'refactor-nrepl.middleware/wrap-refactor)
