{:user {:plugins [[lein-cloverage                    "1.0.9"]
                  [lein-fore-prob                    "0.1.2"]

                  ; Check for outdated dependencies
                  [lein-ancient                      "0.6.10"]

                  [lein-figwheel                     "0.5.10"]
                  [venantius/ultra                   "0.5.1"]]

        :dependencies [[org.clojure/tools.namespace  "0.2.11"]

                       ;; Inject symbols in the REPL's global ns
                       ;; http://dev.solita.fi/2014/03/18/pimp-my-repl.html
                       ;; http://docs.caudate.me/lucidity/lucid-core.html#core-inject
                       [im.chit/lucid.core.inject    "1.3.9"]]

        :ultra {:repl {:sort-keys false ; don't sort collections before printing
                       }}

        :injections [(require 'lucid.core.inject)
                     (lucid.core.inject/in
                       ;; help function
                       [clojure.repl :refer [doc]]

                       ;; Refresh namespaces without reloading the REPL
                       [clojure.tools.namespace.repl :refer [refresh]])]

        :signing {:gpg-key "E5B26621"}}}
