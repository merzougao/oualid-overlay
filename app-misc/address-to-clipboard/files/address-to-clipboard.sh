#!/bin/sh

ADDRESS_BOOK=$HOME/.address-book

selection=$({ cat "$ADDRESS_BOOK"; printf "Add New Contact\n"; } | dmenu -p "Address to copy to clipboard:") || exit 0
[ "$selection" = "Add New Contact" ] && dmenu -p "Add new [NAME <ADDRESS>]:" < /dev/null >> $ADDRESS_BOOK && exit 0
echo "$selection" | tr -d \\n | xclip -selection clipboard
