#!/bin/sh

fd -tf . $HOME | dmenu -p "filepath to copy:" | tr -d \\n | xclip -selection clipboard
