#!/usr/bin/env bash

# ----------------------------------------------------------
# Rclone Multi-Remote Auto-Mounter (with automatic colon)
# - Reads remote names from an .env file
# - Mounts each remote to ~/mnt/<remote_name>
# - Automatically appends ':' if missing
# - Re-mounts automatically if the mount is lost
# ----------------------------------------------------------

# Path to your .env file
ENV_FILE="$HOME/.config/rclone-mounter.env"

# Base directory for mounts
BASE_MOUNT_DIR="$HOME/mnt"

# Load environment variables from the .env file
if [ -f "$ENV_FILE" ]; then
    # shellcheck source=/dev/null
    source "$ENV_FILE"
else
    echo "[ERROR] ENV file not found: $ENV_FILE"
    exit 1
fi

# Collect all remote variables into an array
declare -a REMOTES
while IFS='=' read -r var value; do
    if [[ $var != "" && $value != "" ]]; then
        REMOTES+=("$value")
    fi
done < <(grep -v '^#' "$ENV_FILE")

# Function to mount a single remote
mount_remote() {
    local remote_name="$1"

    # Ensure remote has a colon at the end
    [[ "$remote_name" != *:* ]] && remote_name="$remote_name:"

    local mount_point="$BASE_MOUNT_DIR/${remote_name%:}"  # strip colon for folder

    # Create mount directory if it doesn't exist
    [ ! -d "$mount_point" ] && mkdir -p "$mount_point"

    echo "[INFO] Mounting $remote_name to $mount_point ..."
    rclone mount "$remote_name" "$mount_point" \
        --daemon \
        --vfs-cache-mode writes \
        --vfs-cache-max-size 1G \
        --vfs-cache-max-age 12h \
        --dir-cache-time 1h
}

# Initial mounting for all remotes
for remote_name in "${REMOTES[@]}"; do
    mount_remote "$remote_name"
done

# Monitor mounts and re-mount if needed
while true; do
    for remote_name in "${REMOTES[@]}"; do
        mount_point="$BASE_MOUNT_DIR/${remote_name%:}"  # strip colon for folder
        if ! mountpoint -q "$mount_point"; then
            echo "[WARN] $remote_name not mounted. Re-mounting..."
            mount_remote "$remote_name"
        fi
    done
    sleep 60
done

