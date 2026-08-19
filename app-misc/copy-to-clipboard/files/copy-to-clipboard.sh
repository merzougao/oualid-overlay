#!/bin/sh

fd -tf . $HOME | dmenu -p "filepath to copy:" | xclip -selection clipboard 
