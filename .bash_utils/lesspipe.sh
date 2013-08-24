#!/bin/sh
# from http://pythonic.pocoo.org/2008/3/28/using-pygments-with-less

case "$1" in
    *.sh|\
    *.[ch]|*.[ch]pp|*.[ch]xx|*.cc|\
    *.clj|\
    *.java|\
    *.js|\
    *.pl|*.pm|*.pod|\
    *.php|\
    *.py|\
    *.rb|*.gem|\
    *.xml|*.xsl|*.html|*.xhtml|*.yml|*.yaml|*.json|\
    *.diff|*.patch)
       pygmentize -g "$1" ;;
    *) exit 0;;
esac
