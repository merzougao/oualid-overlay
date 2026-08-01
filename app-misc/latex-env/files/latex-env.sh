#!/bin/sh

result=$(fd -t file -e tex . "$HOME" | dmenu) || exit 0

dir=$(dirname "$result")
file=$(basename "$result")

tabbed_id="$(tabbed -c -d -s)"
st -w "$tabbed_id" -e kak "$result" &
st -w "$tabbed_id" -e sh -c 'cd "$1" && echo "$2" | entr pdflatex "$2"' _ "$dir" "$file" &
