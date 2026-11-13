#!/usr/bin/env bash
# Disk usage report | Storage रिपोर्ट
set -u
printf '=== Filesystem usage ===\n'
df -h
printf '\n=== Current directory size ===\n'
du -sh . 2>/dev/null || echo 'Directory size unavailable'
printf '\nRead-only report; no files were deleted.\n'
