#!/bin/bash

set -euo pipefail

export LC_NUMERIC="C"

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <base_directory>"
    echo "Example: sudo $0 /mnt/fs_tests"
    exit 1
fi

BASE_DIR="$1"
TEST_FILES_DIR="$BASE_DIR/test_files"
MOUNT_POINTS_DIR="$BASE_DIR/mount_points"
RESULTS_DIR="$BASE_DIR/results"

PARTITION_LABELS=("ntfs_1k" "ntfs_2k" "ntfs_4k" "ext4_1k" "ext4_2k" "ext4_4k")
BLOCK_SIZES_BYTES=(1024 2048 4096 1024 2048 4096)
FILESYSTEMS=("ntfs" "ntfs" "ntfs" "ext4" "ext4" "ext4")

if [ "$EUID" -ne 0 ]; then
  echo "Error: This script must be run with sudo."
  exit 1
fi

# Create CSV headers for different types of space analysis
SPACE_EFFICIENCY_CSV="$RESULTS_DIR/space_efficiency.csv"
FRAGMENTATION_CSV="$RESULTS_DIR/fragmentation_analysis.csv"
PARTITION_USAGE_CSV="$RESULTS_DIR/partition_usage.csv"
DETAILED_SPACE_CSV="$RESULTS_DIR/detailed_space_analysis.csv"

echo "partition_label,filesystem,block_size_bytes,file_name,file_size_bytes,allocated_bytes,wasted_bytes,efficiency_percent,waste_percent" > "$SPACE_EFFICIENCY_CSV"
echo "partition_label,filesystem,block_size_bytes,test_scenario,total_files,total_file_size_bytes,total_allocated_bytes,fragmentation_percent,avg_waste_per_file" > "$FRAGMENTATION_CSV"
echo "partition_label,filesystem,block_size_bytes,total_bytes,used_bytes,available_bytes,usage_percent,inodes_total,inodes_used,inodes_free" > "$PARTITION_USAGE_CSV"
echo "partition_label,filesystem,block_size_bytes,file_size_category,avg_efficiency,min_efficiency,max_efficiency,std_efficiency,sample_count" > "$DETAILED_SPACE_CSV"

echo "=== COMPREHENSIVE SPACE UTILIZATION ANALYSIS ==="
echo "Following PDF requirements and professor guidelines"
echo "Testing practical block sizes: 1KB, 2KB, 4KB"
echo ""

# Function to get file allocation info
get_allocation_info() {
    local file_path="$1"
    local filesystem="$2"
    local block_size="$3"

    if [[ "$filesystem" == "ext4" ]]; then
        # For ext4, use stat to get actual allocated blocks
        local stat_output=$(stat -c "%s %b %B" "$file_path" 2>/dev/null || echo "0 0 512")
        local actual_size=$(echo "$stat_output" | awk '{print $1}')
        local blocks_allocated=$(echo "$stat_output" | awk '{print $2}')
        local block_size_stat=$(echo "$stat_output" | awk '{print $3}')
        local allocated_bytes=$((blocks_allocated * block_size_stat))

        echo "$actual_size $allocated_bytes"
    else
        # For NTFS, calculate based on cluster size (more predictable)
        local actual_size=$(stat -c "%s" "$file_path" 2>/dev/null || echo "0")
        local allocated_blocks=$(( (actual_size + block_size - 1) / block_size ))
        local allocated_bytes=$((allocated_blocks * block_size))

        echo "$actual_size $allocated_bytes"
    fi
}

# Function to get partition usage info
get_partition_info() {
    local mount_point="$1"
    local filesystem="$2"

    # Get space usage
    local df_output=$(df -B1 "$mount_point" | tail -1)
    local total_space=$(echo "$df_output" | awk '{print $2}')
    local used_space=$(echo "$df_output" | awk '{print $3}')
    local available_space=$(echo "$df_output" | awk '{print $4}')
    local usage_percent=$(echo "$df_output" | awk '{print $5}' | tr -d '%')

    # Get inode usage
    local df_inodes=$(df -i "$mount_point" | tail -1)
    local inodes_total=$(echo "$df_inodes" | awk '{print $2}')
    local inodes_used=$(echo "$df_inodes" | awk '{print $3}')
    local inodes_free=$(echo "$df_inodes" | awk '{print $4}')

    echo "$total_space $used_space $available_space $usage_percent $inodes_total $inodes_used $inodes_free"
}

# Function to test space efficiency for different file sizes
test_space_efficiency() {
    local label="$1"
    local filesystem="$2"
    local block_size="$3"
    local mount_point="$4"

    echo "  Testing space efficiency on $label..."

    # Test files of different sizes to understand block utilization
    local test_sizes=(
        # Sub-block sizes (test internal fragmentation)
        100 500 800
        # Block boundary sizes
        1024 1536 2048 2560 3072 4096 4608
        # Multi-block sizes
        5120 8192 10240 16384 32768
        # Larger files
        65536 131072 262144 524288 1048576
    )

    local efficiency_data=()
    local total_waste=0
    local total_files=0

    for size in "${test_sizes[@]}"; do
        # Skip if file size exceeds reasonable limits for the block size test
        if [ $size -gt 1048576 ]; then
            continue
        fi

        # Create test file of specific size
        local test_file="$mount_point/space_test_${size}b"
        dd if=/dev/zero of="$test_file" bs=1 count=$size status=none 2>/dev/null
        sync

        # Get allocation information
        local alloc_info=$(get_allocation_info "$test_file" "$filesystem" "$block_size")
        local actual_size=$(echo "$alloc_info" | awk '{print $1}')
        local allocated_bytes=$(echo "$alloc_info" | awk '{print $2}')

        # Calculate efficiency metrics
        local wasted_bytes=$((allocated_bytes - actual_size))
        local efficiency=0
        local waste_percent=0

        if [ $allocated_bytes -gt 0 ]; then
            efficiency=$(echo "scale=2; $actual_size * 100 / $allocated_bytes" | bc)
            waste_percent=$(echo "scale=2; $wasted_bytes * 100 / $allocated_bytes" | bc)
        fi

        # Store data
        echo "$label,$filesystem,$block_size,test_${size}b,$actual_size,$allocated_bytes,$wasted_bytes,$efficiency,$waste_percent" >> "$SPACE_EFFICIENCY_CSV"

        efficiency_data+=("$efficiency")
        total_waste=$((total_waste + wasted_bytes))
        total_files=$((total_files + 1))

        # Clean up
        rm "$test_file"
    done

    # Calculate summary statistics for this partition
    local avg_efficiency=$(printf '%s\n' "${efficiency_data[@]}" | awk '{sum+=$1} END {print sum/NR}')
    local min_efficiency=$(printf '%s\n' "${efficiency_data[@]}" | sort -n | head -1)
    local max_efficiency=$(printf '%s\n' "${efficiency_data[@]}" | sort -n | tail -1)

    echo "$label,$filesystem,$block_size,all_sizes,$avg_efficiency,$min_efficiency,$max_efficiency,0,$total_files" >> "$DETAILED_SPACE_CSV"
}

# Function to test fragmentation scenarios
test_fragmentation_scenarios() {
    local label="$1"
    local filesystem="$2"
    local block_size="$3"
    local mount_point="$4"

    echo "  Testing fragmentation scenarios on $label..."

    # Scenario 1: Many small files (worst case for large blocks)
    local scenario_dir="$mount_point/fragmentation_test"
    mkdir -p "$scenario_dir"

    local small_file_size=100  # 100 bytes - much smaller than any block
    local num_small_files=50
    local total_actual_size=$((small_file_size * num_small_files))
    local total_allocated=0

    echo "    Creating $num_small_files small files ($small_file_size bytes each)..."

    for ((i=1; i<=num_small_files; i++)); do
        local small_file="$scenario_dir/small_$i"
        dd if=/dev/zero of="$small_file" bs=1 count=$small_file_size status=none 2>/dev/null
    done
    sync

    # Calculate total allocation for small files
    for ((i=1; i<=num_small_files; i++)); do
        local small_file="$scenario_dir/small_$i"
        local alloc_info=$(get_allocation_info "$small_file" "$filesystem" "$block_size")
        local allocated=$(echo "$alloc_info" | awk '{print $2}')
        total_allocated=$((total_allocated + allocated))
    done

    local fragmentation_percent=0
    if [ $total_allocated -gt 0 ]; then
        fragmentation_percent=$(echo "scale=2; ($total_allocated - $total_actual_size) * 100 / $total_allocated" | bc)
    fi
    local avg_waste_per_file=$(echo "scale=2; ($total_allocated - $total_actual_size) / $num_small_files" | bc)

    echo "$label,$filesystem,$block_size,many_small_files,$num_small_files,$total_actual_size,$total_allocated,$fragmentation_percent,$avg_waste_per_file" >> "$FRAGMENTATION_CSV"

    # Clean up scenario 1
    rm -rf "$scenario_dir"

    # Scenario 2: Mixed file sizes (realistic usage)
    mkdir -p "$scenario_dir"

    local mixed_sizes=(50 500 1500 4500 8000 15000)
    local mixed_total_actual=0
    local mixed_total_allocated=0
    local mixed_file_count=${#mixed_sizes[@]}

    echo "    Creating mixed-size files..."

    for i in "${!mixed_sizes[@]}"; do
        local size=${mixed_sizes[$i]}
        local mixed_file="$scenario_dir/mixed_$i"
        dd if=/dev/zero of="$mixed_file" bs=1 count=$size status=none 2>/dev/null
        mixed_total_actual=$((mixed_total_actual + size))

        local alloc_info=$(get_allocation_info "$mixed_file" "$filesystem" "$block_size")
        local allocated=$(echo "$alloc_info" | awk '{print $2}')
        mixed_total_allocated=$((mixed_total_allocated + allocated))
    done
    sync

    local mixed_fragmentation=0
    if [ $mixed_total_allocated -gt 0 ]; then
        mixed_fragmentation=$(echo "scale=2; ($mixed_total_allocated - $mixed_total_actual) * 100 / $mixed_total_allocated" | bc)
    fi
    local mixed_avg_waste=$(echo "scale=2; ($mixed_total_allocated - $mixed_total_actual) / $mixed_file_count" | bc)

    echo "$label,$filesystem,$block_size,mixed_sizes,$mixed_file_count,$mixed_total_actual,$mixed_total_allocated,$mixed_fragmentation,$mixed_avg_waste" >> "$FRAGMENTATION_CSV"

    # Clean up scenario 2
    rm -rf "$scenario_dir"
}

# Main testing loop
echo "Starting comprehensive space utilization tests..."
echo ""

for i in "${!PARTITION_LABELS[@]}"; do
    label=${PARTITION_LABELS[$i]}
    fs=${FILESYSTEMS[$i]}
    block_size=${BLOCK_SIZES_BYTES[$i]}
    mount_point="$MOUNT_POINTS_DIR/$label"

    if ! mountpoint -q "$mount_point"; then
        echo "Warning: Mount point $mount_point is not active. Skipping tests for $label."
        continue
    fi

    echo "=== Testing partition: $label ($fs, ${block_size}B blocks) ==="

    # Get initial partition information
    partition_info=$(get_partition_info "$mount_point" "$fs")
    echo "$label,$fs,$block_size,$partition_info" >> "$PARTITION_USAGE_CSV"

    # Test space efficiency
    test_space_efficiency "$label" "$fs" "$block_size" "$mount_point"

    # Test fragmentation scenarios
    test_fragmentation_scenarios "$label" "$fs" "$block_size" "$mount_point"

    # Get final partition information
    partition_info_final=$(get_partition_info "$mount_point" "$fs")
    echo "$label,$fs,$block_size,$partition_info_final" >> "$PARTITION_USAGE_CSV"

    echo "  Completed tests for $label"
    echo ""
done

echo "=== SPACE UTILIZATION ANALYSIS COMPLETE ==="
echo ""
echo "Results saved to:"
echo "  - Space efficiency per file: $SPACE_EFFICIENCY_CSV"
echo "  - Fragmentation analysis: $FRAGMENTATION_CSV"
echo "  - Partition usage: $PARTITION_USAGE_CSV"
echo "  - Detailed statistics: $DETAILED_SPACE_CSV"
echo ""

# Generate quick summary
echo "=== QUICK SPACE EFFICIENCY SUMMARY ==="
echo "Average space efficiency by filesystem and block size:"
awk -F',' 'NR>1 && $8 > 0 {
    key=$2","$3
    sum[key]+=$8
    count[key]++
}
END {
    for(k in sum) {
        split(k,parts,",")
        printf "%-8s %6s bytes: %5.1f%% efficient\n", parts[1], parts[2], sum[k]/count[k]
    }
}' "$SPACE_EFFICIENCY_CSV" | sort

echo ""
echo "=== FRAGMENTATION IMPACT SUMMARY ==="
echo "Average fragmentation by scenario:"
awk -F',' 'NR>1 {
    key=$2","$3","$4
    sum[key]+=$7
    count[key]++
}
END {
    for(k in sum) {
        split(k,parts,",")
        printf "%-8s %6s bytes %-18s: %5.1f%% fragmentation\n", parts[1], parts[2], parts[3], sum[k]/count[k]
    }
}' "$FRAGMENTATION_CSV" | sort

echo ""
echo "=== THEORETICAL VS ACTUAL SPACE USAGE ==="
echo "Block size impact on small files (100 bytes):"
awk -F',' 'NR>1 && $4=="test_100b" {
    printf "%-8s %6s bytes: %d bytes allocated for 100-byte file (%.1f%% waste)\n", $2, $3, $6, $9
}' "$SPACE_EFFICIENCY_CSV" | sort

echo ""
echo "For detailed analysis, process the CSV files with your analysis scripts."
echo "This data demonstrates the space-speed tradeoff as required by the project."
