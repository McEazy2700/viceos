#!/usr/bin/env bash

exec="$1"
# Remove quotes that might be in the command
exec=$(echo "$exec" | sed 's/^"//;s/"$//')

# Launch the application
hyprctl dispatch exec "$exec" &
