#!/bin/sh

result=$(fd -tf -e pdf . $HOME | dmenu)
[ -n "$result" ] && setsid -f zathura "$result" >/dev/null 2>&1

