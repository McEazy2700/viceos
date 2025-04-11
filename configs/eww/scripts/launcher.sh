#!/usr/bin/env bash

query="$1"
# Use wofi for Wayland app discovery
apps=$(find /run/current-system/sw/share/applications -name "*.desktop" | sort)

# Filter apps based on query
if [[ -n "$query" ]]; then
  filtered_apps=$(grep -l "Name=.*$query" $apps)
else
  filtered_apps=$apps
fi

# Process results
for app in $filtered_apps; do
  name=$(grep "^Name=" "$app" | head -1 | cut -d= -f2)
  icon=$(grep "^Icon=" "$app" | head -1 | cut -d= -f2)
  exec=$(grep "^Exec=" "$app" | head -1 | cut -d= -f2- | sed 's/%[a-zA-Z]//g')
  echo "{\"name\":\"$name\",\"icon\":\"$icon\",\"exec\":\"$exec\"}"
done
