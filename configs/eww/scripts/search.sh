#!/usr/bin/env bash

query="$1"
echo "$query" > /tmp/eww_search_query
apps=$(find /run/current-system/sw/share/applications ~/.local/share/applications -name "*.desktop" 2>/dev/null)

results="["
first=true

for app in $apps; do
  name=$(grep "^Name=" "$app" 2>/dev/null | head -1 | cut -d= -f2)
  # Skip if no name found
  [ -z "$name" ] && continue
  
  # Filter by query if provided
  if [ -n "$query" ] && ! echo "$name" | grep -qi "$query"; then
    continue
  fi
  
  exec=$(grep "^Exec=" "$app" 2>/dev/null | head -1 | cut -d= -f2- | sed 's/%[a-zA-Z]//g')
  # Skip if no executable found
  [ -z "$exec" ] && continue
  
  if [ "$first" = true ]; then
    first=false
  else
    results+=","
  fi
  
  # Escape quotes for JSON
  name=$(echo "$name" | sed 's/"/\\"/g')
  exec=$(echo "$exec" | sed 's/"/\\"/g')
  
  results+="{\"name\":\"$name\",\"exec\":\"$exec\"}"
done

results+="]"
echo "$results"
