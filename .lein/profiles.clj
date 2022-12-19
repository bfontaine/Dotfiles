{:user {:dependencies [[org.clojure/tools.namespace "1.3.0"]],
        :middleware [cider-nrepl.plugin/middleware
                     refactor-nrepl.plugin/middleware],
        :plugins [; https://github.com/clojure-emacs/cider-nrepl#via-leiningen
                  [cider/cider-nrepl "0.29.0"] [refactor-nrepl "3.6.0"]
                  [lein-cloverage "1.2.4"] #_[lein-fore-prob "0.1.2"]
                  [lein-nvd "2.0.0"]
                  ; Check for outdated dependencies
                  [lein-ancient "0.7.0"]
                  ; Check for bad coding style
                  [lein-bikeshed "0.5.2"] [lein-kibit "0.1.8"]
                  [jonase/eastwood "1.3.0"]
                  ;; lein-test when something changes
                  [com.jakemccrary/lein-test-refresh "0.25.0"]
                  [lein-figwheel "0.5.20"] #_[venantius/ultra "0.6.0"]],
        :signing {:gpg-key "E5B26621"},
        :ultra {:stacktraces false, ; don't break my stacktraces thanks
                :repl {:sort-keys false ; don't sort collections before printing
                      }}}}
