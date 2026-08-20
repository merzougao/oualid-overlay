#!/bin/sh

export MBLAZE_EDITOR="st -e kak"

handle_draft() {
  draft="$1"
  [ -f "$draft" ] || return 1
  xsetroot -name "Draft: $draft"
  sending=$(printf "yes\n" | dmenu -p "Confirm sending?") || return 1

  [ "$sending" = "yes" ] || return 1
  xsetroot -name "Sending..."
  mcom -r "$draft" -send || return 1
  xsetroot -name "Email sent."
  return 0
}

action=$(printf "list mails\ncompose new\nrefresh\n" | dmenu -p "Emails") || exit 0
case "$action" in
  "compose new")
  	draft=$(printf "c\n" | mcom | sed "s|^.*mcom: cancelled draft ||")
  	handle_draft "$draft"
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

    email_title=$(COLUMNS=140 mscan "$email_id" -f "%f -- %S")
    xsetroot -name "Viewing email: $email_title"
    st -e sh -c "mshow \"$email_id\" | kak -e \"set buffer filetype mail\""

    xsetroot -name "Selected email: $email_title"
    action=$(printf 'list mails\nreply\nforward\ndelete\n' | dmenu -p "Next action?") || exit 0

    case "$action" in
      "reply" | "forward")
        [ "$action" = "reply" ] 		&& prog="mrep" && flag=-R
        [ "$action" = "forward" ] 	&& prog="mfwd" && flag=-P
        draft=$(printf "c\n" | "$prog" "$email_id" | sed "s|^.*mcom: cancelled draft ||")
			handle_draft "$draft" || continue
			mflag "$flag" "$email_id"
			break
        ;;
    esac
  done
  ;;
esac
