#!/usr/bin/env bash
set -euo pipefail

SNIPPET_DIR="$HOME/Documents/snippets"

echo "DEBUG: Script started."

# Choose snippet
TEMPLATE=$(find "$SNIPPET_DIR" -type f | zenity --list --column="Snippets" --height=400 --width=600 --title="Select Snippet")

# Check if user cancelled snippet selection
if [ -z "${TEMPLATE:-}" ]; then
  echo "DEBUG: Snippet selection cancelled. Exiting."
  exit 1
fi

echo "DEBUG: Selected TEMPLATE: '$TEMPLATE'"

# Read content from the selected template file
CONTENT=$(<"$TEMPLATE")
echo "DEBUG: Initial CONTENT (from template file):"
echo "$CONTENT"
echo "--- END Initial CONTENT ---"

# Extract placeholders (e.g., {{variable_name}})
# The '|| true' ensures the script doesn't exit if grep finds no matches.
VARS=$(grep -o '{{[^}]*}}' "$TEMPLATE" | sort -u || true)
echo "DEBUG: Extracted VARS (placeholders found): '$VARS'"

# If no placeholders, type immediately
if [ -z "$VARS" ]; then
  echo "DEBUG: No placeholders found. Copying and typing content directly."
  wl-copy "$CONTENT"
  sleep 0.3
  if wtype "$(wl-paste)"; then
    notify-send "✅ Snippet inserted"
    echo "DEBUG: Successfully typed content (no placeholders)."
  else
    notify-send "❌ Typing failed (no placeholders) — snippet copied to clipboard"
    echo "DEBUG: Failed to type content (no placeholders). wtype exit code: $?"
  fi
  exit 0
fi

# --- Placeholder handling starts here ---

echo "DEBUG: Placeholders found. Building Zenity form."

# Build Zenity form arguments based on extracted placeholders
FORM_ARGS=()
for VAR in $VARS; do
  # Remove '{{' and '}}' to get the clean key name for Zenity
  KEY=${VAR//[\{\}]/}
  FORM_ARGS+=(--add-entry="$KEY")
done
echo "DEBUG: Zenity FORM_ARGS array: ${FORM_ARGS[@]}"

# Display Zenity form and capture user input
USER_INPUT=$(zenity --forms --title="Fill snippet variables" "${FORM_ARGS[@]}")

# Check if user cancelled the form
if [ -z "${USER_INPUT:-}" ]; then
  echo "DEBUG: Zenity form cancelled. Exiting."
  exit 1
fi

echo "DEBUG: Zenity USER_INPUT (raw): '$USER_INPUT'"

# Replace variables in CONTENT with user input
IFS="|" read -r -a VALS <<< "$USER_INPUT"
echo "DEBUG: VALS array (from Zenity input):"
declare -p VALS # Prints the array in a readable format

i=0
for VAR in $VARS; do
  KEY=${VAR//[\{\}]/} # Get the clean key name again
  # Get the value, interpreting backslash escapes (like \n)
  # Use printf %b to interpret backslash escapes
  REPLACEMENT_VALUE=$(printf %b "${VALS[$i]:-}")

  if [ -z "${VALS[$i]:-}" ]; then
    echo "WARNING: Value for placeholder '{{${KEY}}}' at index $i is empty or missing from Zenity input."
  fi
  echo "DEBUG: Replacing '{{${KEY}}}' with interpreted value: '$REPLACEMENT_VALUE'"
  # Perform global replacement for the current placeholder
  CONTENT=${CONTENT//{{${KEY}}}/$REPLACEMENT_VALUE}
  ((i++))
done

echo "DEBUG: Final CONTENT after all replacements (with newlines interpreted):"
echo "$CONTENT"
echo "--- END Final CONTENT ---"

# Type the final result into the focused input
wl-copy "$CONTENT"
sleep 0.3 # Give clipboard a moment to update

# Attempt to type the content and check its success
# The 'if' condition only checks the exit status, no need to re-run wtype
if wtype "$(wl-paste)"; then
  notify-send "✅ Snippet typed and clipboard restored"
  echo "DEBUG: Successfully typed final content."
else
  notify-send "❌ Typing failed — snippet copied to clipboard"
  echo "DEBUG: Failed to type final content. wtype exit code: $?"
fi

echo "DEBUG: Script finished."
