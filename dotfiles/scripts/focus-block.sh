#!/usr/bin/env bash

# Focus block with Watson + Tomato timer
# Starts a Watson frame, runs tomato-c, then stops and logs the duration.

read -p "📁 What project are you working on? (e.g. clientX): " project
read -p "🏷️  Tags (space-separated, e.g. +deepwork +focus): " tags
read -p "📝 Description (optional): " description

# Start Watson timer
watson start "$project $tags" --at "$description"
start_time=$(date +"%s")

echo "🚀 Focus block started. Starting tomato timer..."
echo "🔔 Press Ctrl+C or close tomato to end."

# Run Pomodoro timer (defaults to 25/5)
tomato

# When done
end_time=$(date +"%s")
duration=$(( (end_time - start_time) / 60 ))
watson stop

echo "✅ Focus block logged in Watson: $duration minutes"
