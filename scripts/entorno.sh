#!/bin/bash
# document_environment.sh

echo "=== SYSTEM ENVIRONMENT DOCUMENTATION ===" > environment_report.txt
echo "Date: $(date)" >> environment_report.txt
echo "" >> environment_report.txt

echo "=== HARDWARE ===" >> environment_report.txt
lscpu >> environment_report.txt
echo "" >> environment_report.txt
lsblk >> environment_report.txt
echo "" >> environment_report.txt

echo "=== KERNEL & OS ===" >> environment_report.txt
uname -a >> environment_report.txt
cat /etc/os-release >> environment_report.txt
echo "" >> environment_report.txt

echo "=== FILESYSTEM SUPPORT ===" >> environment_report.txt
cat /proc/filesystems >> environment_report.txt
echo "" >> environment_report.txt

echo "=== MEMORY ===" >> environment_report.txt
free -h >> environment_report.txt
echo "" >> environment_report.txt

echo "=== USB DEVICE INFO ===" >> environment_report.txt
lsusb >> environment_report.txt
hdparm -I /dev/sdb >> environment_report.txt 2>/dev/null
