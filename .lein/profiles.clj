{:user {:plugins [[lein-cloverage                    "1.0.6"]
                  [lein-fore-prob                    "0.1.2"]

                  ; Check for outdated dependencies
                  [lein-ancient                      "0.6.10"]

                  ; Code quality
                  [lein-kibit                        "0.1.3"]
                  [lein-bikeshed                     "0.4.1"]
                  [slamhound                         "1.5.5"]
                  [jonase/eastwood                   "0.2.3"]

                  [lein-pprint                       "1.1.2"]
                  [lein-figwheel                     "0.5.9"]
                  [cider/cider-nrepl                 "0.14.0"]
                  [venantius/ultra                   "0.5.1"]
                  [venantius/yagni                   "0.1.4"]]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :signing {:gpg-key "E5B26621"}}}
