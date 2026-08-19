#!/bin/sh

programs=(
	"st"
	"qutebrowser"
	"zathura-fuzzy"
	"steam"
	"kakoune-open"
	"bluetooth-connect"
	"latex-env"
	"web-launch"
	"copy-to-clipboard"
	"mblaze-dmenu"
	"address-to-clipboard"
)

result=$(printf "%s\n" ${programs[@]} | dmenu -p "run:" ) || exit 0

$result &
