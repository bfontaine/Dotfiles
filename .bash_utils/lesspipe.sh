#!/bin/sh
# from http://pythonic.pocoo.org/2008/3/28/using-pygments-with-less

case "$1" in
    *.sh|\
    *.[chCH]|*.[ch]pp|*.[ch]xx|*.cc|*.c++|\
    *.clj|\
    *.html|*.xhtml|\
    *.js|\
    *.java|\
    *.json|\
    *.md|*.markdown|\
    *.ml|*.mli|\
    *.pl|*.pm|*.pod|\
    *.php|\
    *.py|\
    *.rb|Rakefile|\
    *.xml|*.xsl|\
    *.yml|*.yaml|\
    *.diff|*.patch)
       pygmentize -g "$1" ;;
    *) exit 0;;
esac
