#!/bin/sh
# idea from http://pythonic.pocoo.org/2008/3/28/using-pygments-with-less

case "$1" in
    *.ada|\
    *.[chCH]|*.[ch]pp|*.[ch]xx|*.cc|*.[ch]++|\
    *.clj|\
    *.html|*.xhtml|\
    *.js|\
    *.java|\
    *.json|\
    *.lua|\
    Makefile|\
    *.ml|*.mli|\
    *.oz|\
    *.pl|*.perl|*.perl6|*.pm|*.pod|\
    *.php|\
    *.py|*.py2|*.py3|*.python2|*.python3|\
    *.rb|Rakefile|\
    *.sh|\
    *.xml|*.xsl|\
    *.yml|*.yaml|\
    *.diff|*.patch)
       pygmentize -g "$1" ;;
    *) exit 0;;
esac
