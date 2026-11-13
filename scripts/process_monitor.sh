#!/usr/bin/env bash
# Process snapshot | Process की एक बार जानकारी
set -u
if command -v ps >/dev/null 2>&1; then
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 16
else
  echo 'ps command is required.'
  exit 1
fi
echo 'Snapshot complete. No process was stopped.'
