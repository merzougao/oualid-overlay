#!/bin/sh

ADDRESS_BOOK=$HOME/.address-book

selection=$( cat "$ADDRESS_BOOK" | dmenu -p "Add new [NAME <ADDRESS>]:") || exit 0
if cat "$ADDRESS_BOOK" | grep -Fxq "$selection"; then
	echo "$selection" | tr -d \\n | xclip -selection clipboard
else
	echo $selection >> $ADDRESS_BOOK && sort -u -o "$ADDRESS_BOOK" "$ADDRESS_BOOK"
fi
