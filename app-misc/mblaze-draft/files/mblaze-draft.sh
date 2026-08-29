#!/bin/sh


PARAMS="h"
USAGE='Usage: mblaze-draft [OPTION]... [FILE]
Manage a draft stored in the MailDir
  -h,  diplay the help and exit

Examples:
  mblaze-draft draft-file
'

log() {
  [ -n "$LOGGER" ] && $LOGGER "$1" && return
  echo "$1" >&1
}

usage(){
  echo "$USAGE"
  exit 2
}

while getopts "$PARAMS" opt; do
  case $opt in
    h) usage;;
  esac
done

[ -n "$1" ] || { echo 'First parameter missing, please provide a draft email.'; exit 1; }

while true; do
  action_draft=$(printf "send\nattach\nedit\n" | dmenu -p "Draft?") || return 1
  case "$action_draft" in
    send)
      log "Sending..."
      if send_error=$(mcom -r "$1" -send 2>&1); then
        log "Email sent."
        exit 0
      fi
      log "Email failed to send."
      ;;
    attach)
      log "Attaching..."
      file_to_attach=$(fd -tf . "$HOME" | dmenu -p "File to attach:") || return 1
      [ -f "$file_to_attach" ] && sed -i "1a Attach: $file_to_attach" -- "$1"
      ;;
    edit)
      log "Editing draft..."
      st -e "$EDITOR" "$1"
      ;;
  esac
done
