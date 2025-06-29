#!/bin/bash
set -e

PARTITION_LABELS=("ntfs_1k" "ntfs_2k" "ntfs_4k" "ext4_1k" "ext4_2k" "ext4_4k")

BASE_DIR="/mnt/fs_tests"
TEST_FILES_DIR="$BASE_DIR/test_files"
MOUNT_POINTS_DIR="$BASE_DIR/mount_points"
RESULTS_DIR="$BASE_DIR/results"

echo "--- Step 1: Creating Directory Structure in '$BASE_DIR' ---"

mkdir -p "$TEST_FILES_DIR"
mkdir -p "$MOUNT_POINTS_DIR"
mkdir -p "$RESULTS_DIR"

for label in "${PARTITION_LABELS[@]}"; do
    mkdir -p "$MOUNT_POINTS_DIR/$label"
done
echo "Directory structure created successfully."

echo ""
echo "--- Step 2: Creating Test Files ---"

dd if=/dev/zero of="$TEST_FILES_DIR/prueba_1kb" bs=1536 count=1 status=none
dd if=/dev/zero of="$TEST_FILES_DIR/prueba_2kb" bs=2560 count=1 status=none
dd if=/dev/zero of="$TEST_FILES_DIR/prueba_4kb" bs=4608 count=1 status=none

echo "Test files created in '$TEST_FILES_DIR'."
ls -lh "$TEST_FILES_DIR"

echo ""
echo "Setup complete. You can now run mount_partitions.sh."

