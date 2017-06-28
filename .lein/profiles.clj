{:user {:plugins [[lein-cloverage                    "1.0.9"]
                  [lein-fore-prob                    "0.1.2"]

                  ; Check for outdated dependencies
                  [lein-ancient                      "0.6.10"]

                  ; Code quality
                  [lein-kibit                        "0.1.5"]
                  [lein-bikeshed                     "0.4.1"]
                  [jonase/eastwood                   "0.2.4"]

                  [lein-pprint                       "1.1.2"]
                  [lein-figwheel                     "0.5.10"]
                  [cider/cider-nrepl                 "0.14.0"]
                  [venantius/ultra                   "0.5.1"]
                  [venantius/yagni                   "0.1.4"]]

        :dependencies [; Code quality
                       [slamhound                    "1.5.5"]
                       [walmartlabs/datascope        "0.1.1"]

                       [org.clojure/tools.namespace  "0.2.11"]

                       ;; Inject symbols in the REPL's global ns
                       ;; http://dev.solita.fi/2014/03/18/pimp-my-repl.html
                       ;; http://docs.caudate.me/lucidity/lucid-core.html#core-inject
                       [im.chit/lucid.core.inject    "1.3.9"]]

        :aliases {"slamhound" ["run" "-m" "slam.hound"]}

        :injections [(require 'lucid.core.inject)
                     (lucid.core.inject/in
                       ;; help function
                       [clojure.repl :refer [doc]]

                       ;; Refresh namespaces without reloading the REPL
                       [clojure.tools.namespace.repl :refer [refresh]])]

        :signing {:gpg-key "E5B26621"}}}
