#!/bin/sh

[ -n "$BROWSER" ] || { echo "Please set the env variable BROWSER"; exit 1; }

if [ -n "$1" ]; then
	q=$(printf %s "$*" | jq -sRr @uri)
	$BROWSER "https://www.google.com/search?q=$q" >/dev/null 2>&1 &
else
	result=$(dmenu < "$HOME"/.browser/bookmarks.txt | sed "s|^[^ ]*\([^ ]*\)|\1|")
	[ -n "$result" ] || exit 1
	$BROWSER "$result"
fi
