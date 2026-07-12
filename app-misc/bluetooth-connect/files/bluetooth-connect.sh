#!/bin/sh

bluetoothctl --timeout 5 scan on &
scan_pid=$!
printf "" | dmenu -p "scanning..." &
dmenu_pid=$!
wait $scan_pid
kill $dmenu_pid
result=$(bluetoothctl devices | dmenu -p "connect :")

mac_address=$(echo $result | sed -E "s|^Device ([0-9A-Fa-f:]{17}) .*|\1|")
xsetroot -name "Attempting to connect to $mac_address"
if bluetoothctl connect $mac_address >/dev/null 2>&1; then
    xsetroot -name "Connected to $mac_address"
else
    xsetroot -name "Failed to connect to $mac_address"
fi
