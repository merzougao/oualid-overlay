#!/bin/sh

result=$(fd -tf . $HOME | dmenu -p "kakoune:" ) || exit 0
st -e kak $result
