#!/usr/bin/env bash
# Linux system summary | Linux system की सामान्य जानकारी
set -u
printf '\n=== Linux System Information ===\n'
for cmd in uname hostname uptime; do
  if command -v "$cmd" >/dev/null 2>&1; then
    printf '\n--- %s ---\n' "$cmd"
    "$cmd" 2>&1 || printf 'Could not read %s\n' "$cmd"
  fi
done
if command -v free >/dev/null 2>&1; then free -h; fi
if command -v df >/dev/null 2>&1; then df -h; fi
printf '\nDone. No system settings were changed.\n'
