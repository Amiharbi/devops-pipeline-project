#!/bin/bash
set -euo pipefail

SOURCE_DIR="${1:-}"
BACKUP_DIR="${2:-$HOME/backups}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

if [ -z "$SOURCE_DIR" ]; then
  echo "Usage: $0 <source_dir> [backup_dir]"
  exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Error: $SOURCE_DIR does not exist"
  exit 1
fi

mkdir -p "$BACKUP_DIR"
ARCHIVE="$BACKUP_DIR/backup_${TIMESTAMP}.tar.gz"

tar -czf "$ARCHIVE" "$SOURCE_DIR"
echo "Backup created: $ARCHIVE"


