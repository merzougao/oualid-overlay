#!/bin/sh

result=$(fd -tf -I -e pdf . $HOME | dmenu -p "open pdf :" )
[ -n "$result" ] && setsid -f zathura "$result" >/dev/null 2>&1

