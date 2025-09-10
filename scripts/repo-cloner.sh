#!/bin/bash

REPO_LIST_FILE="$1"

if [[ ! -f "$REPO_LIST_FILE" ]]; then
  echo "❌ File not found: $REPO_LIST_FILE"
  echo "Usage: $0 <repo-list-file>"
  exit 1
fi

while IFS= read -r line; do
  [[ -z "$line" || "$line" =~ ^# ]] && continue

  base_dir=$(echo "$line" | awk '{print $1}')
  repo_url=$(echo "$line" | awk '{print $2}')

  # Expand ~ manually
  eval base_dir="$base_dir"

  # Extract repo name
  repo_name=$(basename -s .git "$repo_url")

  # Final target dir
  target_dir="$base_dir/$repo_name"

  if [[ -d "$target_dir/.git" ]]; then
    echo "🔄 Pulling in '$target_dir'..."
    (cd "$target_dir" && git pull)
  else
    echo "📥 Cloning '$repo_url' into '$target_dir'..."
    mkdir -p "$base_dir"
    git clone "$repo_url" "$target_dir"
  fi

done < "$REPO_LIST_FILE"

