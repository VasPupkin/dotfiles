#!/usr/bin/env bash
# Time-stamp: <Last changed 2018-03-30 11:13:52>
# search/bookmarks script for rofi

shopt -s lastpipe

# variables
BROWSER1=firefox
BROWSER2=palemoon
BOOKMARKS=~/.bookmarks.html
PARCER=~/.config/awesome/scripts/html_parse.pl

# check browser process
if [ $(pgrep -c $BROWSER1) -gt 0 ]; then
    BROWSER=$BROWSER1
elif [ $(pgrep -c $BROWSER2) -gt 0 ]; then
    BROWSER=$BROWSER2
else
    BROWSER=$BROWSER1
    exec $BROWSER &
fi

# prepare bookmarks
perl $PARCER $BOOKMARKS | grep -v 'place:' > /tmp/bookmarks
BOOKMARKS=/tmp/bookmarks

# use rofi to display bookmarks and select one
rofi -dmenu -p $BROWSER: < "$BOOKMARKS" | read -a "url"

[[ ! $url ]] && exit

# bookmarks open
if [ $(echo ${url[@]} | grep -o 'http[^"]*') ]; then 
    url=$(echo ${url[@]} | grep -o 'http[^"]*')
    $BROWSER "${url[0]}"
    exit
fi

# search in specified place
google() {
x=$@; $BROWSER "https://www.google.ru/search?q=${x// /+}"
}
duckimage() {
x=$@
$BROWSER "https://duckduckgo.com/?q=${x// /+}&ia=images&iax=1"
}
duckvideo() {
x=$@
$BROWSER "https://duckduckgo.com/?q=${x// /+}&ia=videos&iax=1"
}
DDG() {
x=$@; $BROWSER "https://duckduckgo.com/?q=${x// /+}"
}
wikipedia() {
x=$@; $BROWSER "https://ru.wikipedia.org/wiki/Special:Search?search=${x// /+}"
}


case "${url[0]}" in
    *.*|*:*|*/*)		     $BROWSER "${url[0]}" ;;
    # aw|awiki)   archwiki    -browser=$BROWSER "${url[@]:1}" ;;
    wi|wiki)    wikipedia "${url[@]:1}" ;;
    # imdb)	imdb        -browser=$BROWSER "${url[@]:1}" ;;
    # aur)	aur         -browser=$BROWSER "${url[@]:1}" ;;
    # pkg)	archpkg     -browser=$BROWSER "${url[@]:1}" ;;
    ddg|S|DDG)	DDG			      "${url[@]:1}" ;;
    go|google)  google "${url[@]:1}" ;;
    # map)	google -m   -browser=$BROWSER "${url[@]:1}" ;;
    #    image)	google -i   -browser=$BROWSER "${url[@]:1}" ;;   
    image) duckimage "${url[@]:1}" ;;   
    #    video)	google -v   -browser=$BROWSER "${url[@]:1}" ;;   
    video) duckvideo "${url[@]:1}" ;;
    # news)	google -n   -browser=$BROWSER "${url[@]:1}" ;;      
    # yt|youtube)	youtube     -browser=$BROWSER "${url[@]:1}" ;;
    # ebay)	ebay        -browser=$BROWSER "${url[@]:1}" ;;
    # pubmed)	pubmed      -browser=$BROWSER "${url[@]:1}" ;;
    # git|github)	github      -browser=$BROWSER "${url[@]:1}" ;;
    rus) notify-send -t 0 -a sdcv "StarDict" "$( sdcv --data-dir ~/dic/eng/ "${url[@]:1}" | tail -n +5 | cut --delimiter=" " --fields=1-100 | head -n 10 )" && exit ;;
    # med)        MED                           "${url[@]:1}" ;;
    *) DDG "${url[@]}" ;;
esac
