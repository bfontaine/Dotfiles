{:user {:plugins [[lein-cloverage                    "1.0.13"]
                  [lein-fore-prob                    "0.1.2"]

                  ; Check for outdated dependencies
                  [lein-ancient                      "0.6.15"]

                  ; Check for bad coding style
                  [lein-bikeshed                      "0.5.1"]
                  [lein-kibit                         "0.1.6"]
                  [jonase/eastwood                    "0.3.4"]

                  ;; lein-test when something changes
                  [com.jakemccrary/lein-test-refresh "0.23.0"]

                  ;; generate tags file
                  ;; https://acidwords.com/posts/2016-12-29-code-indexing-with-lein-codeindex.html
                  [lein-codeindex                    "0.1.0"]

                  [lein-figwheel                     "0.5.18"]
                  [venantius/ultra                   "0.5.2"]]

        :dependencies [[org.clojure/tools.namespace  "0.2.11"]]

        :ultra {:stacktraces false ; don't break my stacktraces thanks
                :repl {:sort-keys false ; don't sort collections before printing
                       }}

        :signing {:gpg-key "E5B26621"}}}
