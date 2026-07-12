#!/bin/sh

programs=(
	"st"
	"qutebrowser"
	"zathura-fuzzy"
	"steam"
	"kakoune-open"
	"bluetooth-connect"
)

result=$(printf "%s\n" ${programs[@]} | dmenu -p "run:" ) || exit 0

$result &
