#!/bin/bash

set -euo pipefail

export LC_NUMERIC="C"

# if [ "$#" -ne 1 ]; then
#     echo "Usage: $0 <base_directory>"
#     echo "Example: sudo $0 /mnt/filesystem_tests"
#     exit 1
# fi

# BASE_DIR="$1"

BASE_DIR="/mnt/fs_tests"
TEST_FILES_DIR="$BASE_DIR/test_files"
MOUNT_POINTS_DIR="$BASE_DIR/mount_points"
RESULTS_DIR="$BASE_DIR/results"

PARTITION_LABELS=("ntfs_1k" "ntfs_2k" "ntfs_4k" "ext4_1k" "ext4_2k" "ext4_4k")
BLOCK_SIZES=("1KiB" "2KiB" "4KiB" "1KiB" "2KiB" "4KiB")
FILESYSTEMS=("ntfs" "ntfs" "ntfs" "ext4" "ext4" "ext4")

TEST_FILE_NAMES=("prueba_1kb" "prueba_2kb" "prueba_4kb")
TEST_FILE_SIZES_KB=(1.5 2.5 4.5)

REPETITIONS=30

if [ "$EUID" -ne 0 ]; then
  echo "Error: This script must be run with sudo."
  exit 1
fi

CSV_FILE="$RESULTS_DIR/speed_results.csv"
echo "partition_label,filesystem,block_size,test_type,file_size_kb,repetition,time_seconds,speed_kibps" > "$CSV_FILE"
echo "--- Starting Speed Tests ---"


for i in "${!PARTITION_LABELS[@]}"; do
    label=${PARTITION_LABELS[$i]}
    fs=${FILESYSTEMS[$i]}
    block_size=${BLOCK_SIZES[$i]}
    mount_point="$MOUNT_POINTS_DIR/$label"

    if ! mountpoint -q "$mount_point"; then
        echo "Warning: Mount point $mount_point is not active. Skipping tests for $label."
        continue
    fi

    for j in "${!TEST_FILE_NAMES[@]}"; do
        file_name=${TEST_FILE_NAMES[$j]}
        file_size_kb=${TEST_FILE_SIZES_KB[$j]}
        source_path="$TEST_FILES_DIR/$file_name"
        dest_path="$mount_point/$file_name"

        echo -e "\nTesting on $label with $file_name..."

        for ((rep=1; rep<=REPETITIONS; rep++)); do
            echo -ne " Repetition $rep/$REPETITIONS\r"

            write_duration=$(TIMEFORMAT='%R'; time (cp "$source_path" "$dest_path" && sync) 2>&1)
            write_speed=$(echo "$file_size_kb / $write_duration" | bc -l)

            echo "$label,$fs,$block_size,write,$file_size_kb,$rep,$write_duration,$write_speed" >> "$CSV_FILE"

            echo 3 > /proc/sys/vm/drop_caches

            read_duration=$(TIMEFORMAT='%R'; time (cp "$dest_path" /dev/null) 2>&1)
            read_speed=$(echo "$file_size_kb / $read_duration" | bc -l)

            echo "$label,$fs,$block_size,read,$file_size_kb,$rep,$read_duration,$read_speed" >> "$CSV_FILE"

            rm "$dest_path"
        done
        echo ""
    done
done

echo -e "\nAll speed tests complete. Results saved to $CSV_FILE"

