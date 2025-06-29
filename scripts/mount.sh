#!/bin/bash

set -e

BASE_DIR="/mnt/fs_tests"

DEVICE_NAMES=(
    "/dev/sdb5"   # Corresponds to ntfs_1k
    "/dev/sdb6"   # Corresponds to ntfs_2k
    "/dev/sdb7"   # Corresponds to ntfs_4k
    "/dev/sdb8"   # Corresponds to ext4_1k
    "/dev/sdb9"   # Corresponds to ext4_2k
    "/dev/sdb10"  # Corresponds to ext4_4k
)

PARTITION_LABELS=("ntfs_1k" "ntfs_2k" "ntfs_4k" "ext4_1k" "ext4_2k" "ext4_4k")
FILESYSTEM_TYPES=("ntfs-3g" "ntfs-3g" "ntfs-3g" "ext4" "ext4" "ext4")

if [ "$EUID" -ne 0 ]; then
  echo "Error: This script must be run with sudo to mount partitions."
  exit 1
fi

echo "--- Mounting Partitions ---"

for i in "${!PARTITION_LABELS[@]}"; do
    label=${PARTITION_LABELS[$i]}
    device=${DEVICE_NAMES[$i]}
    fstype=${FILESYSTEM_TYPES[$i]}
    mount_point="$BASE_DIR/mount_points/$label"

    if [ ! -b "$device" ]; then
        echo "Error: Device '$device' not found. Please check your DEVICE_NAMES configuration."
        exit 1
    fi

    echo "Mounting $device (type: $fstype) to $mount_point..."
    umount "$mount_point" &>/dev/null || true
    mount -t "$fstype" "$device" "$mount_point"
done

echo ""
echo "All partitions mounted successfully."
echo "You can now run the benchmark with run_tests.sh."
mount | grep "$BASE_DIR"

