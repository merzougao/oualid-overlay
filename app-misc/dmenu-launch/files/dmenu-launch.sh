#!/bin/sh

programs="stt \"tabbed st -w\"
qutebrowser \"qutebrowser\"
zathura-fuzzy \"zathura-fuzzy\"
steam \"steam\"
kakoune-open \"kakoune-open\"
bluetooth-connect \"bluetooth-connect\"
latex-env \"latex-env\"
web-launch \"web-launch\"
copy-to-clipboard \"copy-to-clipboard\"
mblaze-dmenu \"mblaze-dmenu\"
address-to-clipboard \"address-to-clipboard\""

result=$(printf '%s\n' "$programs" | dmenu -p "run:") || exit 0
app=$(printf '%s\n' "$result" | sed 's/^[^"]*"//;s/"$//')
sh -c "$app" &
