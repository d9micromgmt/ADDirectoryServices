(set-env!
  :source-paths #{"src"}
  :dependencies '[[org.clojure/clojure       "1.7.0" :scope "provided"]
                  [degree9/boot-d9micromgmt  "0.2.3"]
                  [boot/core                 "2.1.2"]])

(require '[degree9.boot-d9micromgmt :refer :all])
(require '[boot.core :as boot])

(def +version+ "0.1.1")

(boot/deftask build
  "Build source files to target."
  []
  (yaml-to-arm)
  (yaml-to-psdsc))
