#!/bin/sh

log() {
  [ -n "$LOGGER" ] && $LOGGER "$1" && return
  echo "$1" >&1
}

ATTACHMENT_TYPES="application/pdf" #This must be | separated, i.e application/pdf|application/xxx, so that sed can consume it

action=$(printf "list mails\ncompose new\nrefresh\n" | dmenu -p "Emails") || exit 0
case "$action" in
  "compose new")
  	draft=$(printf "c\n" | MBLAZE_EDITOR="st -e $EDITOR" mcom | sed "s|^.*mcom: cancelled draft ||")
  	[ -f "$draft" ] && log "Draft: $draft" && mblaze-draft "$draft" || continue
    ;;
  "refresh" | "list mails")
    refresh_status=
    if [ "$action" = "refresh" ]; then
      log "Refreshing emails..."
      refresh_status="[$(mbsync -a)]"
      log "$refresh_status"
    fi
  while true; do
    log "${refresh_status}Listing Emails..."
    selection=$( mlist "$HOME/Mail/gmail/INBOX" | msort -d -r | mseq -S | COLUMNS=140 mscan -f "%c%u%r %-3n %10d %30f %t %2i%s" | dmenu -l 30 ) || exit 0
    email_id=$( printf '%s\n' "$selection" | sed 's|^[^0-9]*\([0-9][0-9]*\).*|\1|' ) || exit 1
    email=$(mseq -r "$email_id") || continue
    [ -f "$email" ] || continue

    email_title=$(COLUMNS=140 mscan "$email" -f "%f -- %S")
    log "Viewing email: $email_title"
    st -e sh -c 'mshow "$0" | $EDITOR -e "set buffer filetype mail"' "$email"
    email=$(printf '%s\n' "$email" | mflag -v -S) || continue
    [ -f "$email" ] || continue

    log "Selected email: $email_title"

    while true; do
      action=$(printf 'list mails\nreply\nforward\ndownload attachment\ndelete\n' | dmenu -p "Next action?") || exit 0

      case "$action" in
        "reply" | "forward")
          [ "$action" = "reply" ] 		&& prog="mrep" && flag=-R
          [ "$action" = "forward" ] 	&& prog="mfwd" && flag=-P
          draft=$(printf "c\n" | MBLAZE_EDITOR="st -e $EDITOR" "$prog" "$email" | sed "s|^.*mcom: cancelled draft ||")
  				[ -f "$draft" ] && log "Draft: $draft" && (mblaze-draft "$draft" || continue 2)
          mflag "$flag" "$email"
          break 2
          ;;
        "download attachment")
          part=$( mshow -t "$email" | sed -nE "\#(${ATTACHMENT_TYPES})#p" | dmenu -p "Select part to download:" | sed "s|^ *\([0-9][0-9]*\).*|\1|") || continue
          [ "$part" -eq "$part" ] && (cd "$HOME" && log "Saved in: $HOME/$(mshow -x "$email" "$part")")
          ;;
      	"list mails") break;;
      esac
  	done
  done
  ;;
esac
