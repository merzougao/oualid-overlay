#!/bin/sh

programs=(
	"st"
	"qutebrowser"
	"zathura-fuzzy"
	"steam"
	"kakoune-open"
	"bluetooth-connect"
	"latex-env"
)

result=$(printf "%s\n" ${programs[@]} | dmenu -p "run:" ) || exit 0

$result &
