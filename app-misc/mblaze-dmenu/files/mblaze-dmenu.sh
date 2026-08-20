#!/bin/sh

ATTACHMENT_TYPES="application/pdf" #This must be | separated, i.e application/pdf|application/xxx, so that sed can consume it
handle_draft() {
  while true; do
    action_draft=$(printf "send\nattach\nedit\n" | dmenu -p "Draft?") || return 1
    case "$action_draft" in
      send)
        xsetroot -name "Sending..."
        if send_error=$(mcom -r "$draft" -send 2>&1); then
          xsetroot -name "Email sent."
          return 0
        fi
        xsetroot -name "Email failed to send."
        ;;
      attach)
        xsetroot -name "Attaching..."
        file_to_attach=$(fd -tf . "$HOME" | dmenu -p "File to attach:") || return 1
        [ -f "$file_to_attach" ] && sed -i "1a Attach: $file_to_attach" -- "$draft"
        ;;
      edit)
        xsetroot -name "Editing draft..."
        st -e kak "$draft"
        ;;
    esac
  done
}

action=$(printf "list mails\ncompose new\nrefresh\n" | dmenu -p "Emails") || exit 0
case "$action" in
  "compose new")
  	draft=$(printf "c\n" | MBLAZE_EDITOR="st -e kak" mcom | sed "s|^.*mcom: cancelled draft ||")
  	[ -f "$draft" ] && xsetroot -name "Draft: $draft" && handle_draft "$draft" || continue
    ;;
  "refresh" | "list mails")
    refresh_status=
    if [ "$action" = "refresh" ]; then
      xsetroot -name "Refreshing emails..."
      refresh_status="[$(mbsync -a)]"
      xsetroot -name "$refresh_status"
    fi
  while true; do
    xsetroot -name "${refresh_status}Listing Emails..."
    selection=$( mlist "$HOME/Mail/gmail/INBOX" | msort -d -r | mseq -S | COLUMNS=140 mscan -f "%c%u%r %-3n %10d %30f %t %2i%s" | dmenu -l 30 ) || exit 0
    email_id=$( printf '%s\n' "$selection" | sed 's|^[^0-9]*\([0-9][0-9]*\).*|\1|' ) || exit 1
    email=$(mseq -r "$email_id") || continue
    [ -f "$email" ] || continue

    email_title=$(COLUMNS=140 mscan "$email" -f "%f -- %S")
    xsetroot -name "Viewing email: $email_title"
    st -e sh -c 'mshow "$0" | kak -e "set buffer filetype mail"' "$email"
    email=$(printf '%s\n' "$email" | mflag -v -S) || continue
    [ -f "$email" ] || continue

    xsetroot -name "Selected email: $email_title"

    while true; do
      action=$(printf 'list mails\nreply\nforward\ndownload attachment\ndelete\n' | dmenu -p "Next action?") || exit 0

      case "$action" in
        "reply" | "forward")
          [ "$action" = "reply" ] 		&& prog="mrep" && flag=-R
          [ "$action" = "forward" ] 	&& prog="mfwd" && flag=-P
          draft=$(printf "c\n" | MBLAZE_EDITOR="st -e kak" "$prog" "$email" | sed "s|^.*mcom: cancelled draft ||")
  				[ -f "$draft" ] && xsetroot -name "Draft: $draft" && (handle_draft "$draft" || continue 2)
          mflag "$flag" "$email"
          break 2
          ;;
        "download attachment")
          part=$( mshow -t "$email" | sed -nE "\#(${ATTACHMENT_TYPES})#p" | dmenu -p "Select part to download:" | sed "s|^ *\([0-9][0-9]*\).*|\1|") || continue
          [ "$part" -eq "$part" ] && (cd "$HOME" && xsetroot -name "Saved in: $HOME/$(mshow -x "$email" "$part")")
          ;;
      esac
  	done
  done
  ;;
esac
