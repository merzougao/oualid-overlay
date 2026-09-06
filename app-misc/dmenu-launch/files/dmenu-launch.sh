#!/bin/sh

programs='stt tabbed st -w
qutebrowser qutebrowser
zathura-fuzzy zathura-fuzzy
steam steam
kakoune-open kakoune-open
bluetooth-connect bluetooth-connect
latex-env latex-env
web-launch web-launch
copy-to-clipboard copy-to-clipboard
email mblaze-dmenu
address-to-clipboard address-to-clipboard
pass-to-clipboard pass-to-clipboard
'

selection=$(printf '%s\n' "$programs" | awk '{ print $1 }' | dmenu "$@" -p "run:") || exit 0
app=$(printf '%s\n' "$programs" | awk -v selection="$selection" '$1 == selection { $1 = ""; print $0 }')
sh -c "$app" &
