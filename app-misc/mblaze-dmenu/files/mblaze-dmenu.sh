#!/bin/sh

handle_draft() {
  draft="$1"
  [ -f "$draft" ] || return 1
  xsetroot -name "Draft: $draft"

  while true; do
    action_draft=$(printf "send\nattach\nedit\ndelete\n" | dmenu -p "Draft?") || return 1
    case "$action_draft" in
    send)
    	xsetroot -name "Sending..."
  		mcom -r "$draft" -send || return 1
  		xsetroot -name "Email sent."
  		return 0
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
		delete)
  		confirmation=$(printf "yes\nno\n" | dmenu -p "sure?")
  		[ "$confirmation" = "yes" ] && rm -rf "$draft" && xsetroot -name "Deleted draft : $draft"
			return 1
		;;
  	esac
  done
  return 1
}

action=$(printf "list mails\ncompose new\nrefresh\n" | dmenu -p "Emails") || exit 0
case "$action" in
  "compose new")
  	draft=$(printf "c\n" | MBLAZE_EDITOR="st -e kak" mcom | sed "s|^.*mcom: cancelled draft ||")
  	handle_draft "$draft"
    ;;
  "refresh" | "list mails")
    refresh_status=
    [ "$action" = "refresh" ] && xsetroot -name "Refreshing emails..."   && refresh_status="[$(mbsync -a)] " && xsetroot -name "$refresh_status"
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
        draft=$(printf "c\n" | MBLAZE_EDITOR="st -e kak" "$prog" "$email_id" | sed "s|^.*mcom: cancelled draft ||")
        handle_draft "$draft" || continue
  			mflag "$flag" "$email_id"
  			break
        ;;
    esac
  done
  ;;
esac
