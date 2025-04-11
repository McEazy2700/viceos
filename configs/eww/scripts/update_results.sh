#!/usr/bin/env bash

# Read from stdin
results=$(cat)

# Update eww variables
eww update search_results="$results"
