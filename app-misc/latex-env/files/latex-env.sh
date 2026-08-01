#!/bin/sh

result=$(fd -t file -e 'tex' . | dmenu) || exit 0

tabbed_id="$(tabbed -c -d -s)"
st -w "$tabbed_id" -e kak $result &
st -w "$tabbed_id" -e sh -c 'echo "$1" | entr pdflatex "$1"' _ "$result" &
