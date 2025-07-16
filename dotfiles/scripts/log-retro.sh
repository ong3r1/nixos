#!/usr/bin/env bash

# Retroactive time logging into Watson
# Prompts for duration, project, tags, and description

read -p "⏳ How long ago did you start? (e.g., 3h, 2h30m): " duration
read -p "🔚 How long did it last? (optional, default = until now): " elapsed
read -p "📁 What project did you work on? (e.g., chores, clientX): " project
read -p "🏷️  Tags? (space-separated, e.g., +home +deepwork): " tags
read -p "📝 Description (optional): " desc

from_time=$(date -d "$duration ago" +"%Y-%m-%dT%H:%M")
if [ -z "$elapsed" ]; then
  to_time=$(date +"%Y-%m-%dT%H:%M")
else
  to_time=$(date -d "$duration ago + $elapsed" +"%Y-%m-%dT%H:%M")
fi

watson add "$project $tags" --from "$from_time" --to "$to_time" --at "$desc"

echo "✅ Logged: [$project $tags] from $from_time to $to_time"
