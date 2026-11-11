#!/bin/bash
set -euo pipefail

DISK_THRESHOLD="${1:-80}"
MEM_THRESHOLD="${2:-80}"

DISK_USED=$(df / | awk 'NR==2 {gsub("%",""); print $5}')
MEM_USED=$(free | awk '/Mem:/ {printf "%d", $3/$2*100}')

echo "Disk usage: ${DISK_USED}% (threshold ${DISK_THRESHOLD}%)"
echo "Memory usage: ${MEM_USED}% (threshold ${MEM_THRESHOLD}%)"

STATUS=0

if [ "$DISK_USED" -ge "$DISK_THRESHOLD" ]; then
  echo "WARNING: disk usage is high"
  STATUS=1
fi

if [ "$MEM_USED" -ge "$MEM_THRESHOLD" ]; then
  echo "WARNING: memory usage is high"
  STATUS=1
fi

exit $STATUS
